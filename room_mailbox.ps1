#enter room login credentials into $user variable
$user = "turrrmeetingroommadr"
$htmlstring = '<P>

    <FONT size=4><STRONG>Meeting Conflicts:<BR></STRONG></FONT>

If you attempted to book this resource and it was declined because of a meeting conflict, please contact the meeting organizer listed above to resolve or attempt to book another available resource/time.
<BR><BR><FONT size=4><STRONG>Note:<BR></STRONG></FONT>
Meeting Organizers/Hosts/Delegates are responsible to clean the room so that it is neat and orderly for the next meeting. Thank you.
<BR><BR><FONT size=4><STRONG>Resource Information:<BR></STRONG></FONT>
                 
<u>Custodian:</u> Huseyin Bolel<BR>  
<u>Location:</u> TUR/Istanbul/Meydan Sokak No:28<BR>
<u>Inbound Phone Number:</u> 111, 203<BR>
<u>Seats:</u> 12<BR>
<pre><FONT size=4 face="Tahoma"><STRONG>Has following services/amenities:</STRONG></FONT>
<FONT face="Tahoma">
Network
Phone
Overhead Projector
</FONT>
</pre>
</P>
'
Set-MailboxFolderPermission -Identity $user -User Default -AccessRights Reviewer
 
Set-MailboxFolderPermission -Identity "$($user):\$(Get-MailboxFolderStatistics -Identity $user | Where-Object {$_.FolderType -eq 'Calendar'} | Select-Object -ExpandProperty Name)" -User Default -AccessRights Reviewer; 
 
Set-MailboxFolderPermission -Identity "$($user):\$(Get-MailboxFolderStatistics -Identity $user | Where-Object {$_.FolderType -eq 'Calendar'} | Select-Object -ExpandProperty Name)" -User Anonymous -AccessRights Reviewer; 
 
Set-calendarprocessing -Identity  $user -AddNewRequestsTentatively $True `
-AddOrganizerToSubject $True `
-AllBookInPolicy $True `
-AllowConflicts $False `
-AllowRecurringMeetings $True `
-AllRequestInPolicy $True `
-AllRequestOutOfPolicy $False `
-AutomateProcessing AutoAccept `
-BookingWindowInDays 365 `
-Confirm `
-ConflictPercentageAllowed $False `
-DeleteAttachments $True `
-DeleteComments $True  `
-DeleteNonCalendarItems $True `
-DeleteSubject $False `
-EnableResponseDetails $True `
-EnforceSchedulingHorizon $True `
-ForwardRequestsToDelegates $False `
-MaximumDurationInMinutes 21600 -OrganizerInfo $True `
-ProcessExternalMeetingMessages $False `
-RemoveForwardedMeetingNotifications $True  `
-RemoveOldMeetingMessages $True `
-RemovePrivateProperty $False `
-ScheduleOnlyDuringWorkHours $False `
-TentativePendingApproval $False `
-AddAdditionalResponse $True `
-AdditionalResponse $htmlstring
 
Set-MailboxCalendarConfiguration -Identity  $user -RemindersEnabled $False
