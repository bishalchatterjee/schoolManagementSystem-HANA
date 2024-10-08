const cds = require('@sap/cds');
const {Student, Subject, GradeScale, Result, Staff, Timetable, Class, AdminLogonValidation, StaffLogonValidation} = cds.entities;

module.exports = cds.service.impl(async (srv) => {
    //Dynamic GET using actions
    srv.on('getSubject', async (req) => {
        var subQuery = null;
        if (req.data.ID) {``
            subQuery = `ID=${req.data.ID}`;
        } else {
            subQuery = `name='${req.data.subName}'`;
        }
        console.log(subQuery);
        try {
            const result = await SELECT.from(Subject).where(subQuery);
            console.log(result);
            return result;
        } catch (error) {
            return { error: error.message };
        }
    });

    // POST operation using custom function
    srv.on('postSubject', async (req,res) => {
        try {
            const { ID, name, description, classLevel } = req.data;

            const existingSubject = await SELECT.one.from(Subject).where({ ID }).or({ name });

            if (existingSubject) {
                return { error: 'A subject with the same ID or name already exists.' };
            } else {
                const result = await INSERT.into(Subject).entries({
                    ID,
                    name,
                    description,
                    classLevel
                });
                console.log(result);
                return result;
            }        
        } catch (error) {
            return { error: error.message };
        }
    });
    
    //POST Multiple Subjects
    srv.on('postManySubject', async (req, res) => {
        // return(req.data);

        try {
            const subjects = req.data.values;
            const result = await INSERT.into(Subject).entries(subjects);
            return result;
        } catch (error) {
            return { error: error.message };
        }
        
        // try {
        //     const subjects = req.data.values;
        //     console.log(subjects);

        //     for (const subject of subjects) {
        //         const { ID, name, description, classLevel } = subject;
    
        //         const existingSubject = await SELECT.one.from(Subject).where({ ID }).or({ name });
    
        //         if (existingSubject) {
        //             return { error: `A subject with the same ID (${ID}) or name (${name}) already exists.` };
        //         } else {
        //             const result = await INSERT.into(Subject).entries({
        //                 ID,
        //                 name,
        //                 description,
        //                 classLevel
        //             });
        //             console.log(result);
        //         }
        //     }
        //     return { message: 'All subjects inserted successfully.' };
        // } catch (error) {
        //     return { error: error.message };
        // }
    });
    

    srv.on('getStaff', async (req) => {
        try {
            const { role, subjectsTaught_ID } = req.data;

            const result = await SELECT.from(Staff).where(`role=${role}`).and(`subjectsTaught_ID=${subjectsTaught_ID}`);
            console.log(result)
            if (result) {
                return result;
            } else {
                return { error: 'No such record was found' };
            }    
        } catch (error) {
            return { error: error.message };
        }
    });

    srv.on('verifyAdminLogon', async (req) => {
        try {
            const { email, password } = req.data;

            const adminExists = await SELECT.one.from(AdminLogonValidation).where({ email }).and({ password });

            console.log(adminExists);

            if (adminExists) {
                // console.log(true);
                // return adminExists;
                return true;
            }else {
                return false;
            }
        } catch (error) {
            return { error:'Authentication failed!' };
        }
    });

    srv.on('verifyStaffLogon', async (req) => {
        try {
            const { email, password } = req.data;

            const staffExists = await SELECT.one.from(StaffLogonValidation).where({ email }).and({ password });

            if (staffExists) {
                // console.log(true);
                // return staffExists;
                return true;
            }else {
                return false;
            }
        } catch (error) {
            return { error: 'Authentication failed!'};
        }
    });


    srv.on('getAnalytics', async (req) => {
        try {
            let query = `
                SELECT 
                    (SELECT COUNT(*) FROM students) AS student_count,
                    (SELECT COUNT(*) FROM subjects) AS subject_count
            `;
    
            let result = await new Promise((resolve, reject) => {
                conn.exec(query, (err, rows) => {
                    if (err) {
                        return reject(err);
                    }
                    resolve(rows);
                });
            });
    
            return result;
    
        } catch (error) {
            return { error: 'Something went wrong!'};
        }
    });
 });