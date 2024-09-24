using {GradeScale, Student, Subject, Staff, Class, Result, Timetable, StaffRole, ClassLevel} from '../db/schema';

service SchoolService @(path: '/myService'){
    entity subject as projection on Subject;
    entity gradeScale as projection on GradeScale;
    entity student as projection on Student;
    entity staff as projection on Staff;
    entity class as projection on Class;
    entity result as projection on Result;
    entity timetable as projection on Timetable;
    
    //Function for GET operations on entities
    function getSubject(ID: Integer, subName: String) returns subject;
    function getStaff(role: StaffRole, subjectsTaught_ID: Integer) returns staff;
    //Action for PUT,POST operations on entities
    action postSubject(ID: Integer, name: String, description: String, classLevel: ClassLevel) returns subject;
    action postManySubject(values : array of  subject) returns subject;

} 
