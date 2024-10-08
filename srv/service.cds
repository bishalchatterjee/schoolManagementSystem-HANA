using {GradeScale, Student, Subject, Staff, Class, Result, Timetable, StaffRole, ClassLevel, AdminLogonValidation, StaffLogonValidation} from '../db/schema';

service SchoolService @(path: '/myService'){
    entity subject as projection on Subject;
    entity gradeScale as projection on GradeScale;
    entity student as projection on Student;
    entity staff as projection on Staff;
    entity class as projection on Class;
    entity result as projection on Result;
    entity timetable as projection on Timetable;
    entity adminLogon as projection on AdminLogonValidation;
    entity staffLogon as projection on StaffLogonValidation;
    
    //Function for GET operations on entities
    function verifyAdminLogon(email: String, password: String) returns Boolean;
    function verifyStaffLogon(email: String, password: String) returns Boolean;

    function getSubject(ID: Integer, subName: String) returns subject;
    function getStaff(role: StaffRole, subjectsTaught_ID: Integer) returns staff;

    function getAnalytics() returns Integer;
   
    //Action for PUT,POST operations on entities
    action postSubject(ID: Integer, name: String, description: String, classLevel: ClassLevel) returns subject;
    action postManySubject(values : array of  subject) returns subject;



} 
