public class HeatmapFullController {

    public String heatmapPageName {get; set;}
    
    public Decimal heatmapDimensions {get; set;}

    public HeatmapFullController() {
        heatmapDimensions = HeatMapSettings__c.getInstance().HeatMapDimensions__c;
        if (heatmapDimensions == 3) {
            heatmapPageName = 'HeatMap3x3';
        } else if (heatmapDimensions == 10) {
            heatmapPageName = 'HeatMap10x10';            
        } else {
            heatmapPageName = 'HeatMap5x5';            
        }
    }
}