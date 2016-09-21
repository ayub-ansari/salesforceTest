/*
 * Mike Ulveling
 * 
 * Keeps track of row selections over a result set (i.e. from a QueryLocator). Typically, rows should be key'd by an SObject Id. 
 * Has accommodations for paginated result sets: 
 * 1) Able to determine the selections which are in the current page
 * 2) Has methods to select/deselect all rows on the current page
 * 3) Upon page refresh (call resetPage()), takes a <table> DOM node reference (which must have a specific structure in its 
 *    checkbox column) that represents the rendering of the results page, and automatically renders current selections into 
 *    it - as well as setting up event handlers on the checkboxes (to merge selections made by the user).
 *    
 * The results page-table is expected to contain a column of checkboxes with the following format:
 * <tr>
 *     <td>
 *          <span class="selectionRowControl">
 *              <input type="checkbox" />
 *              <span selectionRowKey="<SObject.Id>" />
 *          </span>
 *     </td>
 *     <!-- any other columns, here... -->
 * </tr>
 * <!-- additional rows here... -->
 */

if (typeof rk == "undefined") {
    var rk = {};
}

rk.PageModel = function(selectionModel, tableEl) {
    this.selectionModel = selectionModel;
    this.reset(tableEl);
}

rk.PageModel.prototype.reset = function (tableEl) {
	this.tableEl = tableEl;
    this.rowKeys = []; // in-order list of row ids
    this.rowKeysSet = {};
}

rk.PageModel.prototype.add = function (rowKey) {
    this.rowKeys.push(rowKey);
    this.rowKeysSet[rowKey] = true;
}

rk.PageModel.prototype.size = function () {
    return this.rowKeys.length;
}

rk.PageModel.prototype.updateAllRows = function () {
    var pageModel = this;
    $(this.tableEl).find('tr').each(function () {
        if ($(this).has('span[selectionRowKey]')) {
            var rowKey = $(this).find('span[selectionRowKey]').attr('selectionRowKey');
            if (pageModel.rowKeysSet[rowKey]) {
                var isSelected = pageModel.selectionModel.has(rowKey);
                $(this).find('input:checkbox')[0].checked = isSelected;
                if (isSelected) {
                    $(this).addClass('selected');
                    $(this).removeClass('unselected');
                } else {
                    $(this).addClass('unselected');
                    $(this).removeClass('selected');
                }
            }
        }
    });
    if (this.paginator) {
        this.paginator.draw();
    }
}

rk.PageModel.prototype.updateRow = function (rowKey, isSelected) {
	// update the checked state of the checkbox:
	if (this.rowKeysSet[rowKey]) {
        $(this.tableEl).find('tr').has('span[selectionRowKey=' + rowKey + ']').find('input:checkbox')[0].checked = isSelected;
    }
	// update the style classes of the row:
	if (this.rowKeysSet[rowKey]) {
        var trEl = $(this.tableEl).find('tr').has('span[selectionRowKey=' + rowKey + ']');
        if (isSelected) {
            trEl.addClass('selected');
            trEl.removeClass('unselected');
        } else {
            trEl.addClass('unselected');
            trEl.removeClass('selected');
        }
    }
	// this.updateRowCheckbox(rowKey, isSelected);
    // this.updateRowStyles(rowKey, isSelected);
	if (this.paginator) {
	    this.paginator.draw();
	}
}

/*
rk.PageModel.prototype.updateRowCheckbox = function (rowKey, isSelected) {
	if (this.rowKeysSet[rowKey]) {
		$(this.tableEl).find('tr').has('span[selectionRowKey=' + rowKey + ']').find('input:checkbox')[0].checked = isSelected;
	}
}

rk.PageModel.prototype.updateRowStyles = function (rowKey, isSelected) {
	if (this.rowKeysSet[rowKey]) {
		var trEl = $(this.tableEl).find('tr').has('span[selectionRowKey=' + rowKey + ']');
		if (isSelected) {
		    trEl.addClass('selected');
		    trEl.removeClass('unselected');
		} else {
		    trEl.addClass('unselected');
		    trEl.removeClass('selected');
		}
	}
}
*/

/* Settings: {DOMElement|JQuery eventListener, DOMElement table} */
rk.SelectionModel = function (settings) {
    this.$listener = settings.eventListener ? $(settings.eventListener) : null;
    this.pageModel = new rk.PageModel(this, settings.table ? settings.table : null);
    this.selections = {}; // set of selection keys
    this.paginator = null; // we need a reference to the paginator so that we can re-draw() it when selections change
}

rk.SelectionModel.prototype.destroy = function (handler) {
    if (this.$listener) {
        this.$listener.unbind('.selectionModel');
    }
}

rk.SelectionModel.prototype.change = function (handler) {
    if (!this.$listener) {
        alert('Error: Cannot bind to the change.selectionModel event -- an Event Listener has not been defined for this rk.SelectionModel');
    }
    this.$listener.bind('selectionsChanged.selectionModel', handler);
}

rk.SelectionModel.prototype._trigger = function (eventType) {
    if (this.$listener) {
        this.$listener.trigger(eventType + '.selectionModel');
    }
}

rk.SelectionModel.prototype.setPaginator = function (paginator) {
    this.pageModel.paginator = paginator;
}

// this should be called whenever the results-page table is refreshed:
rk.SelectionModel.prototype.resetPage = function (tableEl) {
    var selModel = this;
    this.pageModel.reset(tableEl);
    if (tableEl) {
        $(tableEl).addClass('selectionModel');
        $(tableEl).find('.selectionRowControl').each(function () {
            var rowKey = $(this).find('span[selectionRowKey]').attr('selectionRowKey');
            // update the PageModel with this page's row-keys:
            selModel.pageModel.add(rowKey);
            selModel.pageModel.updateRow(rowKey, selModel.has(rowKey));
            // add a change handler to each checkbox, to update the SelectionModel:
            $(this).find('input:checkbox').change(function () { 
                selModel.set(rowKey, this.checked); 
                selModel.pageModel.updateRow(rowKey, this.checked);
                selModel._trigger('selectionsChanged');
            });
        });
        $(tableEl).find('input:checkbox.selectAll').each(function () {
            $(this).change(function () { 
                if (this.checked) {
                    selModel.selectPage(); 
                } else {
                    selModel.deselectPage(); 
                }
            });
        });
    }
}

// returns the total number of selections:
rk.SelectionModel.prototype.getCount = function () {
    var count = 0;
    for (var key in this.selections) {
        count++;
    }
    return count;
}

// returns the number of selections that coincide with the current page:
rk.SelectionModel.prototype.getPageCount = function () {
    var count = 0;
    for (var i=0; i < this.pageModel.rowKeys.length; i++) {
        if (this.selections[this.pageModel.rowKeys[i]]) {
            count++;
        }
    }
    return count;
}

rk.SelectionModel.prototype._select = function (rowKey) {
    if (this.pageModel && this.pageModel.tableEl) {
        // in the current page table, find the <span> corresponding to the given rowKey, and grab any data() that has been set onto it...
        var rowData = $(this.pageModel.tableEl).find('span[selectionRowKey=' + rowKey + ']').data('rowData');
        this.selections[rowKey] = rowData ? rowData : {};
    } else {
        this.selections[rowKey] = {};
    }
}

rk.SelectionModel.prototype._deselect = function (rowKey) {
    delete this.selections[rowKey];
}

// updates the selection model and also re-renders into the results table
rk.SelectionModel.prototype.selectPage = function () {
    for (var i=0; i < this.pageModel.rowKeys.length; i++) {
        this._select(this.pageModel.rowKeys[i]);
    }
    this.pageModel.updateAllRows();
    this._trigger('selectionsChanged');
}

// updates the selection model and also re-renders into the results table
rk.SelectionModel.prototype.deselectPage = function () {
    for (var i=0; i < this.pageModel.rowKeys.length; i++) {
        this._deselect(this.pageModel.rowKeys[i]);
    }
    this.pageModel.updateAllRows();
    this._trigger('selectionsChanged');
}

// updates the selection model and also re-renders into the results table
rk.SelectionModel.prototype.clearAll = function () {
    this.selections = {};
    this.pageModel.updateAllRows();
    this._trigger('selectionsChanged');
}

// updates the selection model but DOES NOT re-render into the results table
rk.SelectionModel.prototype.set = function (rowKey, isSelected) {
    if (this.selections[rowKey] && !isSelected) {
    	delete this.selections[rowKey];
    } else if (!this.selections[rowKey] && isSelected) {
    	// this.selections[rowKey] = true;
    	this._select(rowKey);
    }
}

rk.SelectionModel.prototype.has = function (rowKey) {
	return this.selections[rowKey];
}

rk.SelectionModel.prototype.getPageSelections = function () {
	var pageSelections = [];
	for (var i=0; i < this.pageModel.rowKeys.length; i++) {
		var key = this.pageModel.rowKeys[i];
		if (this.selections[key]) {
			pageSelections.push(key);
		}
	}
	return pageSelections;
}

