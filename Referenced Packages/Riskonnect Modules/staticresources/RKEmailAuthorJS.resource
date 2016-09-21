// Self-executing anonymous function expression
(function(window) {
	// Make class available in global scope
	window.RKPaginator = RKPaginator;
	var context = this;

	// Class declaration / constructor
	// ---------------------------------------------------------------------
	function RKPaginator(_pageSize, _recordSetSFID, _pageSetDOMID, _controlDOMID) {
		this.currPage;
		this.numRecordsOnCurrentPage;
		this.numPages;

		this.PAGE_SIZE = _pageSize;
		this.recordSetId = _recordSetSFID;
		this.pageSetId = _pageSetDOMID;
		this.controlId = _controlDOMID;
		// this.init();
	}

	RKPaginator.prototype = {
		//
		// Public properties
		// ---------------------------------------------------------------------
		
		// Action enumerations
		action : {
			FIRST : { func: 'firstPage' },
			PREV  : { page: 'prevPage'  },
			NEXT  : { page: 'nextPage'  },
			LAST  : { page: 'lastPage'  }
		},
		// Records per page (this is not changeable outside the code for this implementation)
		PAGE_SIZE   : 5,
		// SFID of the hidden record set
		recordSetId : 'attachment_set',
		// ID (non-SF) of the paginated record set
		pageSetId	: 'select_attachments',
		// ID (non-SF) of the div containing the page controls
		controlId	: 'page_controls',


		//
		// Public methods
		// ---------------------------------------------------------------------

		// Clears currently loaded page
		clearCurrentPage:function() {
			$('div#'+this.pageSetId+' table').hide();
			count = getNumRecordsOnCurrentPage();
			while (count >= 1) {
				$('div#'+this.pageSetId+' table tr:eq('+count+')').remove();
				count--;
			}
		},

		// Call this after you've loaded your record set to get the total number of pages. You can do this when the page loads
		// if you're loading your record set right away. Otherwise, call this after you've rerendered the record set.
		calcNumPages:function() {
			setCurrPage(1);
			setNumPages(Math.ceil(($('[id$='+this.recordSetId+'] table tr').length - 1) / this.PAGE_SIZE));
		},

		// Load page logic
		loadPage:function(page) {
			numRecords = $('[id$='+this.recordSetId+'] table tr').length - 1;
			count = 1;
			while (count <= numRecords && count <= this.PAGE_SIZE) {
				$('[id$='+this.recordSetId+'] table tr:eq(' + (count + (this.PAGE_SIZE * (page - 1))) + ')').clone().appendTo('div#'+this.pageSetId+' table');
				count++;
			}
			setNumRecordsOnCurrentPage(count - 1);
			$('div#'+this.pageSetId+' table').fadeIn('fast');
		},

		// First pass at page change logic. It can definitely be improved I believe, but for now this will do to get the project
		// out the door.
		changePage:function(el, action) {
			if (arguments.callee.caller.name == 'onclick' && el.className == 'inactive') {
				return false;
			}
			this.clearCurrentPage();

			switch (action) {
				// Go to first page of the record set
				case this.action.FIRST:
					setCurrPage(1);
					$(el).prop('class', 'inactive');
					$(el).parent('div#'+this.controlId).find('img').eq(1).prop('class', 'inactive');
					$(el).parent('div#'+this.controlId).find('img').eq(2).prop('class', '');
					$(el).parent('div#'+this.controlId).find('img').eq(3).prop('class', '');
				break;

				// Get previous page of the record set
				case this.action.PREV:
					setCurrPage(getCurrPage() - 1);
					if (getCurrPage() == 1) {
						$(el).prop('class', 'inactive');
						$(el).parent('div#'+this.controlId).find('img').eq(0).prop('class', 'inactive');
					}

					$(el).parent('div#'+this.controlId).find('img').eq(2).prop('class', '');
					$(el).parent('div#'+this.controlId).find('img').eq(3).prop('class', '');
				break;

				// Get next page of the record set
				case this.action.NEXT:
					setCurrPage(getCurrPage() + 1);
					if (getCurrPage() == getNumPages()) {
						$(el).prop('class', 'inactive');
						$(el).parent('div#'+this.controlId).find('img').eq(3).prop('class', 'inactive');
					}

					$(el).parent('div#'+this.controlId).find('img').eq(0).prop('class', '');
					$(el).parent('div#'+this.controlId).find('img').eq(1).prop('class', '');
				break;

				// Go to last page of the record set
				case this.action.LAST:
					setCurrPage(getNumPages());
					$(el).prop('class', 'inactive');
					$(el).parent('div#'+this.controlId).find('img').eq(2).prop('class', 'inactive');
					$(el).parent('div#'+this.controlId).find('img').eq(0).prop('class', '');
					$(el).parent('div#'+this.controlId).find('img').eq(1).prop('class', '');
				break;
			}

			$('span#pageNum').html(getCurrPage());		// set page num on screen
			this.loadPage(getCurrPage());				// load the page based on the action
		}
	};

	// Private methods
	// --------------------------------------------------------------------
	function getNumPages() { return context._numPages; }
	function setNumPages(numPages) { context._numPages = numPages; }

	function getNumRecordsOnCurrentPage() { return context._numRecordsOnCurrentPage; }
	function setNumRecordsOnCurrentPage(numRecords) { context._numRecordsOnCurrentPage = numRecords; }

	function getCurrPage() { return context._currPage; }
	function setCurrPage(currPage) { context._currPage = currPage; }

}(window)); // Import window global var
// --------------------------------------------------------------------
// parameters: page size, SFID of the hidden record set, ID (non-SF) of the paginated record set, ID (non-SF) of the div containing the page controls
var emailPaginator = new RKPaginator(5, 'attachment_set', 'select_attachments', 'page_controls');

// Main RKEmail object
var RKEmail = {
	// mode selector enum object
	MODE : {
		HTML : { type: 'HTML', value: 'switchToHTMLModeJS' },
		TEXT : { type: 'TEXT', value: 'switchToTextModeJS' }	
	},
	// Controller-related object vars
	jsonFolders : null,
	emailTemplateOutput : null,				// template body
	emailSubjectOutput : null,				// template subject
	hasTemplateError : null,				// did we encounter a template error
	templateErrorMsg : null,				// template error message
	templateType : null,					// template type (i.e. HTML or TEXT)
	selectedAttachmentIds : null,			// comma-delimited list of selected attachment ids
	// The RKEmail instance of an WYSIHTML5 editor.
	editor : null,
	// Holds the type of mode the editor
	modeObj : null,
	// Use this global JS var to temporarily hold local attachment Ids in order to "check" those attachments automatically after the the attachment content div is rerendered.
	localAttachmentIds : [],
	// We use this global array to track which attachments are selected. If the user runs a cancel action, we have to uncheck the attachments in the hidden set.
	tempSelectedAttIds : [],
	// Callback for iframe function that processes the uploaded attachment
	fileUploadCallBack:function(localId, localName, localSize) {
		this.localAttachmentIds.push(localId);
		// add the attachments that were selected between the time of the attachment dialog window opening and a local file being uploaded successfully
		$('[id$=attachment_set] input[type="checkbox"]:checked').each(function() {
			RKEmail.localAttachmentIds.push($(this.parentNode).find('input[type="hidden"]').val());
		});
		processLocalAttachment(localId, localName, localSize);
	},
	// Callback for iframe function that initiates the blocking pane/loader
	fileUploadLoaderCallBack:function() {
		$('div#attachment_overlay').css({
			'height' : $('div#attachmentsWrapper').innerHeight(),
			'width'  : $('div#attachmentsWrapper').innerWidth()
		}).fadeIn('fast', function() {
			RKEmail.centerElement($('div#attachmentsWrapper'), $('div#attachment_overlay_loader'));
			$('div#attachment_overlay_loader').fadeIn('fast');
		});
	},
	// Callback for iframe function that detected an error (only supports file-too-large error at the moment)
	fileUploadErrorCallBack:function(invalidSize) {
		$('div#attachment_overlay_loader').fadeOut('fast', function() {
			$('span#invalidSize').html(invalidSize.replace(/\B(?=(\d{3})+(?!\d))/g, ","));
			RKEmail.centerElement($('div#attachmentsWrapper'), $('div#attachment_error'));
			$('div#attachment_error').fadeIn('fast');
		});
	},
	// Closes the file upload error dialog window
	closeFileUploadErrorDialog:function() {
		$('div#attachment_error').fadeOut('fast', function() {
			$('div#attachment_overlay').fadeOut('fast');
		});
	},
	// Closes inline file uploader dialog box
	closeFileUploadDialog:function() {
		// Set the newly uploaded file checkbox to checked and run the allocation function
		for (i = 0; i < this.localAttachmentIds.length; ++i) {
			$('input[value="'+this.localAttachmentIds[i]+'"]').siblings('input[type="checkbox"]').prop('checked', true);
			// this.replicateCheckEvent($('input[value="'+this.localAttachmentIds[i]+'"]').siblings('input[type="checkbox"]').get(0));
		}

		// Check for existing attachment selections and change selected prop of input checkboxes
		if (this.selectedAttachmentIds != "") {
			console.log('RKEmail: Found selected attachments that must be processed.');
			idArray = this.selectedAttachmentIds.split(',');
			for (i = 0; i < idArray.length; ++i) {
				$('input[value="'+idArray[i]+'"]').siblings('input[type="checkbox"]').prop('checked', true);
			}
		}

		// simulate first page click
		emailPaginator.changePage($('div#'+emailPaginator.controlId+' img').get(0), emailPaginator.action.FIRST);
		this.checkAllocation();

		$('div#attachment_overlay_loader').fadeOut('fast', function() {
			$('div#attachment_overlay').fadeOut('fast');
		});

		emailPaginator.calcNumPages();
	},
	// Warning dialog function
	warningDialog:function(mode) {
		this.modeObj = mode;

		// Check to see if we need to show the caution dialog box
		if ((this.modeObj.type == this.MODE.HTML.type && $('.textarea').val() != '') ||
			(this.modeObj.type == this.MODE.TEXT.type && this.editor.getValue() != '')) {
			$('div#overlay').fadeIn("fast", function() {
				RKEmail.centerElement(window, $('div#warningDialog'));
				$('div#warningDialog').fadeIn("fast");
			});
		} else {
			this.modeChange();
		}
	},
	// Call the global VF action function
	modeChange:function() {
		// clear editor content first
		$('.textarea').val('');
		window[this.modeObj.value]();
	},
	// Grab the body of the email and set a hidden input value that we will reference in the controller
	getBody:function() {
		var body_string = $('.textarea').val();
		var body_text_only;
		
		if ($('iframe.wysihtml5-sandbox').get(0)) {
			body_text_only = $('iframe.wysihtml5-sandbox').contents().find('body').get(0).innerText;
		} else {
			body_text_only = body_string;
		}

		if (body_string == '' || body_string == null) {
			alert('empty body string detected'); // handle this some how??
			return false;
		}
		
		$('input[name="body_string"]').val(body_string);
		$('input[name="body_text_only"]').val(body_text_only);
	},
	// Standard function to center an element in the viewport (bound = parent element, el = element to center)
	centerElement:function(bound, el) {
		$(el).css({
			left: (($(bound).outerWidth() - $(el).outerWidth()) / 2),
			top : (($(bound).outerHeight() - $(el).outerHeight()) / 2)
		});
	},
	// Closes the dialog loader and blocking pane
	closeDialogLoader:function() {
		$('div#ajaxDialog').fadeOut("fast", function() {
			$('div#overlay').fadeOut("fast", function() {
				$('body').css('overflow', 'visible');
			});
		});
	},
	// "Closes" the dialog window passed to the function (el) and the dialog loader + blocking pane
	closeDialogWindow:function(el) {
		$('div#'+el).fadeOut("fast", function() {
			RKEmail.closeDialogLoader();
			// $('div#attachmentSize').css('width', '0%');
		});
	},
	// START : AJAX helper functions to initiate blocking pane while AJAX request is processing
	startGetEmailFolders:function() {
		$('div#overlay').fadeIn("fast", function() {
			$('p#ajaxDialogMsg').text('loading');
			RKEmail.centerElement(window, $('div#ajaxDialog'));

			$('div#ajaxDialog').fadeIn("fast", function() {
				getEmailFolders();
			});
		});
	},
	startGetRecipients:function() {
		$('div#overlay').fadeIn("fast", function() {
			$('p#ajaxDialogMsg').text('loading');
			RKEmail.centerElement(window, $('div#ajaxDialog'));

			$('div#ajaxDialog').fadeIn("fast", function() {
				getRecipients();
			});
		});
	},
	startGetAttachments:function() {
		$('div#overlay').fadeIn("fast", function() {
			$('p#ajaxDialogMsg').text('loading');
			RKEmail.centerElement(window, $('div#ajaxDialog'));

			$('div#ajaxDialog').fadeIn("fast", function() {
				getAttachments();
			});
		});
	},
	selectTemplate:function(el) {
		$('div#templateWrapper').fadeOut("fast", function() {
			$('p#ajaxDialogMsg').text('applying');
			RKEmail.centerElement(window, $('div#ajaxDialog'));

			$('div#ajaxDialog').fadeIn("fast", function() {
				getSelectedTemplate(el.id, el.className);
			});
		});
	},
	// END : AJAX helper functions
	//
	// Parses JSON object built on the controller side and creates a jQuery accordion-supported object based on that data
	openRecipientsDialog:function() {
		$('div#ajaxDialog').fadeOut("fast", function() {
			RKEmail.centerElement(window, $('div#recipientsWrapper'));
			$('div#recipientsWrapper').fadeIn('fast');
			$('body').css('overflow', 'hidden');
			RKEmail.Recipient.homogenizeListWidths();
		});
	},
	// General function to set the iframe dimensions based on the content size within it
	setFrameDimensions:function(el) {
		var elWidths = $(el).contents().find('*').map(function() {
			return($(this).outerWidth(true));
		});

		var elHeights = $(el).contents().find('*').map(function() {
			return($(this).outerHeight(true));
		});

		var maxWidth  = Math.max.apply(Math, elWidths);
		var maxHeight = Math.max.apply(Math, elHeights);

		$(el).css({
			'background-color' 				: 'rgb(255, 255, 255)',
			'border-collapse' 				: 'separate',
			'border'						: '1px solid rgb(0, 0, 0)',
			'clear'							: 'none',
			'display'						: 'block',
			'float'							: 'none',
			'margin'						: '2px',
			'outline'						: 'rgb(0, 0, 0) none 0px',
			'outline-offset'				: '0px',
			'padding'						: '2px',
			'position'						: 'static',
			'top'							: 'auto',
			'left'							: 'auto',
			'right'							: 'auto',
			'bottom'						: 'auto',
			'z-index'						: 'auto',
			'vertical-align'				: 'baseline',
			'text-align'					: 'start',
			'box-sizing'					: 'content-box',
			'-webkit-box-shadow'			: 'none',
			'box-shadow'					: 'none',
			'border-top-right-radius'		: '0px',
			'border-bottom-right-radius'	: '0px',
			'border-bottom-left-radius'		: '0px',
			'border-top-left-radius'		: '0px',
			'width'							: (maxWidth + 15) + 'px',
			'height'						: (maxHeight + 15) + 'px'
		});

		// BK : We have to set the dimensions again manually in order for the iframe dimensions to match its content dimensions
		$(el).css({'width' : maxWidth + 'px', 'height' : maxHeight + 'px'});
	},
	setFrame:function() {
		this.setFrameDimensions('iframe.wysihtml5-sandbox'); // Adjust iframe size to match iframe contents
		setTimeout(function() { RKEmail.setFrameDimensions('iframe.wysihtml5-sandbox'); }, 100); // Repeat after 100ms due to unknown bug
	},
	processSelectedTemplate:function() {
		if (this.hasTemplateError) {
			$('#errorDialogMsg').html(this.templateErrorMsg);
			$('div#ajaxDialog').fadeOut("fast", function() {
				RKEmail.centerElement(window, $('div#errorDialog'));
				$('div#errorDialog').fadeIn("fast");
			});
		} else {
			$('[id$=subject]').val(this.emailSubjectOutput); // Set the subject line if any (merged)
			// Check to see what type of template we're dealing with
			if (this.templateType == 'TEXT') {
				// kill editor
				$('.wysihtml5-sandbox').remove();
				$('.wysihtml5-toolbar').remove();
				this.editor = null;
				// Just set the textarea value to the template output (merged). Also replace html break tags with carriage returns. (\r\n for Windows, \n for UNIX)
				$('.textarea').show().val(this.emailTemplateOutput.replace(/<br \/>/g, '\r\n'));
			} else if (this.templateType == 'HTML') {
				if (this.editor == null) { // If the editor is not loaded instantiate it
					$('.textarea').wysihtml5();
					this.editor = $('.textarea').data('wysihtml5').editor;
					this.editor.observe('load', function() { // The editor loads asynchronously so we need to add a callback function before accessing it
						RKEmail.editor.setValue(RKEmail.emailTemplateOutput); // Set the mail body to the template output (merged)
						RKEmail.setFrame();
					});
				} else { // Editor is already loaded
					this.editor.setValue(RKEmail.emailTemplateOutput);
					this.setFrame();
				}
			}

			this.closeDialogLoader();
		}
	},
	// Parses JSON object built on the controller side and creates a jQuery accordion-supported object based on that data
	openEmailTemplatesDialog:function() {
		$('div#ajaxDialog').fadeOut("fast", function() {
			// Parse JSON return and display the email folder list in the template wrapper DIV
			var folderData = $.parseJSON(RKEmail.jsonFolders);
			if (folderData.folders) {
				// Build accordion div
				var output = '<div id="accordion">';
				for (var key in folderData.folders) {
					for (var folder in folderData.folders[key]) {
						output += '<h3>'+folder+'</h3>';
						output += '<div><ul>';
						for (var record in folderData.folders[key][folder]) {
							id = folderData.folders[key][folder][record].id;
							val = folderData.folders[key][folder][record].name;
							type = folderData.folders[key][folder][record].type;
							output += '<li id="'+id+'" class="'+type+'" onclick="RKEmail.selectTemplate(this);">';
							output += '<table width="100%"><tr><td width="90%">'+val+'</td><td width="10%" style="text-align: right;">'+type.toUpperCase()+'</td></tr></table>';
							output += '</li>';
						}
						output += '</ul></div>';
					}
				}
				$('div#templateData').html(output);
				$('div#templateWrapper').css({'display' : 'block', 'visibility' : 'hidden'});
				var maxWidth = $('div#templateWrapper').outerWidth();
				$('div#accordion').accordion({collapsible: true, autoHeight: false, clearStyle: true, heightStyle: "content", active: false});
				$('div#templateWrapper').css({'width' : maxWidth+'px', 'height' : '60%', 'overflow-y' : 'scroll', 'opacity' : 0, 'visibility' : 'visible'})
				RKEmail.centerElement(window, $('div#templateWrapper'));
				$('div#templateWrapper').animate({ opacity: 1.0 }, "fast");
				$('body').css('overflow', 'hidden');
			} else {
				alert('no data found');
			}
			// $(jsonFolderObject.folders).each(function(k, v) {
			// 	alert(v.name);
			// });
		});
	},
	// Special function for closing an AJAX loader window; clean-up necessary if completing an attachment save
	closeAttachmentDialogLoader:function() {
		this.closeDialogLoader();
		emailPaginator.clearCurrentPage();
		this.tempSelectedAttIds.length = 0;
		this.localAttachmentIds.length = 0;
	},
	// Special function for closing the attachment dialog; a few clean-up calls must be made
	closeAttachmentDialog:function() {
		$('div#attachmentsWrapper').fadeOut("fast", function() {
			RKEmail.handleAttachmentCancelAction();
			emailPaginator.clearCurrentPage();
			RKEmail.checkAllocation();
			RKEmail.closeDialogLoader();
		});
	},
	// We need this function to clear the checkboxes across all "pages" when a cancel action is selected. We build selected ids in a global array and then remove
	// them as we uncheck them in the hidden attachment set.
	handleAttachmentCancelAction:function() {
		for (i = 0; i < this.tempSelectedAttIds.length; ++i) {
			$('[id$=attachment_set] input[name="'+this.tempSelectedAttIds[i]+'"]').prop('checked', false);
		}
		// clear array
		this.tempSelectedAttIds.length = 0;
		this.localAttachmentIds.length = 0;
	},
	openAttachmentDialog:function() {
		// Load first page
		emailPaginator.calcNumPages();
		emailPaginator.loadPage(1);

		// Fade in page overlay
		$('div#ajaxDialog').fadeOut("fast", function() {
			RKEmail.centerElement(window, $('div#attachmentsWrapper'));

			// Check for existing attachment selections and change selected prop of input checkboxes
			if (RKEmail.selectedAttachmentIds != "") {
				idArray = RKEmail.selectedAttachmentIds.split(',');
				for (i = 0; i < idArray.length; ++i) {
					$('input[value="'+idArray[i]+'"]').siblings('input[type="checkbox"]').prop('checked', true);
				}
				RKEmail.checkAllocation();
			}

			$('div#attachmentsWrapper').fadeIn("fast");
			// $('body').css('overflow', 'hidden');
		});
	},
	startSelectedAttachments:function() {
		$('div#attachmentsWrapper').fadeOut("fast", function() {
			$('p#ajaxDialogMsg').text('saving');
			RKEmail.centerElement(window, $('div#ajaxDialog'));

			$('div#ajaxDialog').fadeIn("fast", function() {
				RKEmail.selectedAttachmentIds = "";
				$('[id$=attachment_set] input[type="checkbox"]:checked').each(function() {
					RKEmail.selectedAttachmentIds += $(this.parentNode).find('input[type="hidden"]').val() + ",";
				});
				RKEmail.selectedAttachmentIds = RKEmail.selectedAttachmentIds.substring(0, RKEmail.selectedAttachmentIds.length - 1);
				getSelectedAttachments(RKEmail.selectedAttachmentIds);
			});
		});
	},
	// Replicate the check event on the hidden attachment set
	replicateCheckEvent:function(item) {
		if (item.checked) {
			$('[id$=attachment_set] input[name="'+item.name+'"]').prop('checked', true);
			// add id to temp global att-id array
			this.tempSelectedAttIds.push(item.name);
		} else {
			$('[id$=attachment_set] input[name="'+item.name+'"]').prop('checked', false);
			// delete id from temp global att-id array
			for (i = 0; i < this.tempSelectedAttIds.length; ++i) {
				if (this.tempSelectedAttIds[i] == item.name) {
					this.tempSelectedAttIds.splice(i, 1);
				}
			}
		}
	},
	// Processes selected attachments and adjusts the attachment-size bar
	checkAllocation:function(item) {
		item = (typeof item === "undefined") ? null : item;

		var ATTACHMENT_THRESHOLD = 10000;
		var totalSize = 0;

		if (item) {
			this.replicateCheckEvent(item);
		}

		// Check the hidden attachment set for selected attachments and aggregate attachment sizes
		$('[id$=attachment_set] input[type="checkbox"]:checked').each(function() {
			itemSize = $(this.parentNode.parentNode).find('td:last-child').text();
			itemSize = parseInt(itemSize.substring(0, itemSize.length - 3));
			totalSize += itemSize;
		});

		if (totalSize > ATTACHMENT_THRESHOLD) {
			// 
			$(item).prop('checked', false);		// Uncheck the file that made the total break the threshold
			this.replicateCheckEvent(item);		// Run the replicateCheckEvent again to uncheck it in the master record set
			return false;
		}

		// Adjust attachment manager bar size
		var percentage = Math.ceil((totalSize / ATTACHMENT_THRESHOLD) * 100);
		$('div#attachmentSize').css('width', percentage + '%');
		// $('span#attachmentSizeValue').html(percentage + '%');
	},
	// 
	// Recipient object code
	// ---------------------
	Recipient : {
		LIST : {
			ADD : 'addList',
			CC  : 'copyList',
			BCC : 'bccList'
		},
		clearLists: function() {
			$('[id$=' + this.LIST.ADD + ']')
		    	.find('option')
		    	.remove()
		    	.end()
		    	.append('<option value="!none!">--None--</option>');

			$('[id$=' + this.LIST.CC + ']')
		    	.find('option')
		    	.remove()
		    	.end()
		    	.append('<option value="!none!">--None--</option>');

			$('[id$=' + this.LIST.BCC + ']')
		    	.find('option')
		    	.remove()
		    	.end()
		    	.append('<option value="!none!">--None--</option>');

		},
		homogenizeListWidths: function() {
			masterListWidth = $('[id$=\\:emailList]').width();
			$('[id$=' + this.LIST.ADD + ']').width(masterListWidth);
			$('[id$=' + this.LIST.CC + ']').width(masterListWidth);
			$('[id$=' + this.LIST.BCC + ']').width(masterListWidth);
		},
		addRecipient: function(type) {
			options = $('[id$=\\:emailList] option:selected');
			if (options.length == 0) {
				return false;
			}

			dest = $('[id$=\\:'+type+']');
			// Remove none option
			if (dest.find('option:nth-child(1)').val() == '!none!') {
				dest.find('option').remove();
			}
			
			options.each(function() {
				shouldSkip = false;
				newEmail = $(this).val();
				newName = $(this).text();
				
				// Check for duplicate name/email pairings
				dest.find('option').each(function() {
					if ($(this).val() == newEmail && $(this).text() == newName) {
						shouldSkip = true;
						return false;
					}
				});
				
				if (shouldSkip) {
					return true;
				}
				
				dest.append($("<option/>", {
					value: $(this).val(),
					text: $(this).text()
				}));
				
				$(this).removeAttr('selected');
			});
		},
		delRecipient: function(type) {
			options = $('[id$=\\:'+type+'] option:selected');
			if (options.length == 0) {
				return false;
			}
			options.remove();
			
			// If no elements left, add none option
			if ($('[id$=\\:'+type+'] option').length == 0) {
				$('[id$=\\:'+type+']').append('<option value="!none!">--None--</option>');
			}
		},
		populateAddresses: function() {
			additionalAddresses= '';
			ccAddresses = '';
			bccAddresses = '';
			
			$('[id$='+ this.LIST.ADD + '] option').each(function() {
				if ($(this).val() != '!none!') {
					additionalAddresses += $(this).val() + '; ';
				}
			});
			
			$('[id$='+ this.LIST.CC + '] option').each(function() {
				if ($(this).val() != '!none!') {
					ccAddresses += $(this).val() + '; ';
				}
			});
			
			$('[id$='+ this.LIST.BCC + '] option').each(function() {
				if ($(this).val() != '!none!') {
					bccAddresses += $(this).val() + '; ';
				}
			});

			if (additionalAddresses) {
				additionalAddresses = additionalAddresses.substring(0, additionalAddresses.length - 2);
				dest = $('[id$=emailAdditionalTo]');
				curr = dest.val();
				
				if (curr) {
					dest.val(curr + '; ' + additionalAddresses);
				} else {
					dest.val(additionalAddresses);
				}
			}
			
			if (ccAddresses) {
				ccAddresses = ccAddresses.substring(0, ccAddresses.length - 2);
				dest = $('[id$=emailCC]');
				curr = dest.val();
				
				if (curr) {
					dest.val(curr + '; ' + ccAddresses);
				} else {
					dest.val(ccAddresses);
				}
			}
			
			if (bccAddresses) {
				bccAddresses = bccAddresses.substring(0, bccAddresses.length - 2);
				dest = $('[id$=emailBCC]');
				curr = dest.val();
				
				if (curr) {
					dest.val(curr + '; ' + bccAddresses);
				} else {
					dest.val(bccAddresses);
				}
			}

			RKEmail.closeDialogWindow('recipientsWrapper');
			RKEmail.Recipient.clearLists();
		}
	}
}