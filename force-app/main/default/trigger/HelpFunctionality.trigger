trigger HelpFunctionality on User(before insert) {
    // Create a list of users to store users who need help
    List<User> usersToHelp = new List<User>();
    
    // Loop through the list of users and search for users who need help
    for (User user : Trigger.new) {
        if (user.Needs_Help__c == true) {
            usersToHelp.add(user);
        }
    }
    
    // Create a new header menu option for help
    Header_Menu_Option__c helpOption = new Header_Menu_Option__c (
        Label__c = 'Help',
        Parent_Option__c = null
    );
    
    // Insert the help option into the menu
    insert helpOption;
    
    // Create a list of sub functionalities
    List<Help_Sub_Functionality__c> helpSubFunctionalities = new List<Help_Sub_Functionality__c>();
    
    // Loop through the list of users and add the corresponding sub functionalities
    for (User user : usersToHelp) {
        helpSubFunctionalities.add(new Help_Sub_Functionality__c (
            User__c = user.Id,
            Header_Menu_Option__c = helpOption.Id
        ));
    }
    
    // Insert the sub functionalities for the help option
    insert helpSubFunctionalities;
    
    // Create a logout menu option
    Header_Menu_Option__c logoutOption = new Header_Menu_Option__c (
        Label__c = 'Logout',
        Parent_Option__c = null
    );
    
    // Insert the logout option into the menu
    insert logoutOption;
}