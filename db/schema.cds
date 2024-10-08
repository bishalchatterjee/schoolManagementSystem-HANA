define Type PhoneNumber : String(10);
define Type Email : String(50);
define Type Grade : String(2);

define Type Address {
    firstLine   : String(100);
    secondLine  : String(50);
    state       : String(50);
    country     : String(50);
    zipCode     : String(10);
}

define Type StaffRole : Integer enum {
    principal      = 1;
    vicePrincipal  = 2;
    teacher        = 3;
    counselor      = 4;
}

define Type TeachingType : Integer enum {
    primaryTeacher    = 1;
    secondaryTeacher  = 2;
}

define Type ClassLevel : Integer enum {
    class1  = 1;
    class2  = 2;
    class3  = 3;
    class4  = 4;
    class5  = 5;
    class6  = 6;
    class7  = 7;
    class8  = 8;
    class9  = 9;
    class10 = 10;
    class11 = 11;
    class12 = 12;
}

define Type StudentCategory : Integer enum {
    excellent = 1;
    average   = 2;
    belowAvg  = 3;
}

entity Subject {
    key ID          : Integer;
    name            : String(50);
    description     : String(200);
    classLevel      : ClassLevel;
    subjectTeacher  : Association to one Staff;
}

entity Class {
    key ID              : Integer;
    name                : String(5);
    classLevel          : ClassLevel;
    classTeacher        : Association to Staff; 
    students            : Association to many Student on students.class = $self;
    subjects            : Association to many Subject;
    timetable           : Composition of many Timetable on timetable.class = $self;
}
entity Timetable {
    key ID           : Integer;
    dayOfWeek        : String(10);
    period           : Integer;
    subject          : Association to Subject;
    teacher          : Association to Staff;  
    class            : Association to Class;
    startTime        : Time;
    endTime          : Time;
}

entity Staff {
    key ID              : Integer;
    firstName           : String(50);
    lastName            : String(50);
    role                : StaffRole;
    phoneNumber         : PhoneNumber;
    email               : Email;
    address             : Address;
    salary              : Decimal(10,2);
    
    // These fields are optional and used only for teachers (handled in business logic)
    teachingType        : TeachingType;
    subjectsTaught      : Association to many Subject;
    classesTaken        : Association to many Class;
}

entity Student {
    key ID              : Integer;
    firstName           : String(50);
    lastName            : String(50);
    dob                 : Date;
    email               : Email;
    phoneNumber         : PhoneNumber;
    address             : Address;
    category            : StudentCategory; 
    results             : Composition of many Result on results.student = $self;
    class               : Association to Class;
}

entity Result {
    key ID           : Integer;
    marks            : Integer;
    grade            : Grade;
    subject          : Association to Subject;
    student          : Association to Student;
    class            : Association to Class;
    examDate         : Date;
}

entity GradeScale {
    key grade        : Grade;
    minimumMarks     : Integer;
    maximumMarks     : Integer;
}

entity AdminLogonValidation {
    Key ID          : Integer;
        email       : String;
        password    : String;
}

entity StaffLogonValidation {
    Key ID          : Integer;
        email       : String;
        password    : String;
}