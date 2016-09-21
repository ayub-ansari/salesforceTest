@isTest
public class ContactDeleteTest {
    @isTest
    static void testContactDeleteTrigger() {
      Contact c1 = new Contact(LastName='CEO');
      insert c1;
      Contact c2 = new Contact(LastName='VP',ReportsToId=c1.Id);
      insert c2;
      Task t1 = new Task(WhoId=c2.Id);
      insert t1;
      delete c2;
      Id taskWho = [SELECT WhoId FROM Task WHERE Id=:t1.Id].WhoId;
      System.assertEquals(c1.Id, taskWho);
    }
}