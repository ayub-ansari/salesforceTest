public class printPreviewController{
    
    public id recordID {get; set;}
    
    public printPreviewController(){
        recordID = ApexPages.currentPage().getParameters().get('recordID');
    }

}