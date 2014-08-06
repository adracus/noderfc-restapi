# SAP Timesheets API
This API offers a wrapper around various RFC calls concerning time sheets and
time recording. It uses basic auth and HTTPS for authentication. For
performance, only the first time you try to get information from the API,
the api stores your data on the API server (password excluded). In order to
clear that data, you can logout after the API usage (`/logout` route).

# Group API Information
This group has currently only one route and represents information about the
API.

## API Information [/]
Shows the version of this API as well as the number of currently logged on
users and the available (in express registered) routes.

### Retrieve API Information [GET]

+ Response 200 (application/json)

        {
            "name": "Activity Recording",
            "version": "0.0.2",
            "no_of_current_users": 0,
            "routes": [
                "GET /",
                "GET /doc",
                "GET /logout",
                "GET /user/:user",
                "GET /user/:user/timesheets",
                "GET /user/:user/timesheets/:id",
                "GET /timesheets",
                "GET /timesheets/:id",
                "DELETE /timesheets/:id",
                "POST /timesheets/post",
                "GET /profile_settings",
                "GET /profile_settings/:id",
                "GET /abs_att_types",
                "GET /abs_att_types/:id",
                "GET /activity_types",
                "GET /activity_types/:id",
                "GET /company_codes",
                "GET /company_codes/:id",
                "GET /cost_centers",
                "GET /cost_centers/:id",
                "GET /controlling_areas",
                "GET /controlling_areas/:id",
                "GET /rejection_reasons",
                "GET /rejection_reasons/:id",
                "GET /receiver_orders",
                "GET /receiver_orders/:id",
                "GET /wbs_elements",
                "GET /wbs_elements/:id",
                "GET /processing_statuses",
                "GET /processing_statuses/:id",
                "POST /timesheets/approve_reject"
            ]
        }

# Group Users
Routes related with a specified or (in case of /me) the current user.

## User Personal info [/user/:user]
Shows the info about the specified user. Invokes the RFC call
`Z_PBR_EMPLOYEE_GET` if the data is not cached.

### Retrieve User personal information [GET]

+ Parameters
    + user (string) ... id of the user which shall be looked up, can also be `me`

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {
            "id": 100190,
            "last_name": "Sanson",
            "first_name": "John",
            "atext": "Mr.",
            "controlling_area": "2000",
            "cost_center": "4100",
            "org_unit": 50014175,
            "is_manager": false,
            "company_code": "3000",
            "factory_calendar": "US",
            "username": "HRPB_EMPL01"
        }

## User timesheet [/user/:user/timesheet]
Returns the timesheet for the specified user. `me` for the current user.

### Retrieve the timesheet [GET]

+ Parameters
    + start_date (optional, date) ... Start date of the timesheet
    + end_date (optional, date) ... End date of the timesheet

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        [
            {
                "counter": "000000002201",
                "status": "30",
                "status_text": "Approved",
                "user_id": 100190,
                "workdate": "2011-11-20T23:00:00.000Z",
                "hours_posted": 0,
                "hours_planned": 8,
                "unit": "H",
                "receiver_order": "800058",
                "network": "",
                "activity": "",
                "wbs_element": "",
                "abs_att_type": "",
                "activity_type": "1410",
                "delete_flag": false,
                "reason": ""
            },
            {
                "counter": "000000002215",
                "status": "30",
                "status_text": "Approved",
                "user_id": 100190,
                "workdate": "2011-11-20T23:00:00.000Z",
                "hours_posted": 0,
                "hours_planned": 8,
                "unit": "H",
                "receiver_order": "800058",
                "network": "",
                "activity": "",
                "wbs_element": "",
                "abs_att_type": "",
                "activity_type": "1410",
                "delete_flag": false,
                "reason": ""
            },
            ...
        ]

## User timesheet by id [/user/:user/timesheet/:id]
Returns the timesheet by id for the specified user. `me` for the current user.

### Retrieve the timesheet [GET]

+ Parameters
    + id (string) ... id of the timesheet

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {
            "counter": "000000002201",
            "status": "30",
            "status_text": "Approved",
            "user_id": 100190,
            "workdate": "2011-11-20T23:00:00.000Z",
            "hours_posted": 0,
            "hours_planned": 8,
            "unit": "H",
            "receiver_order": "800058",
            "network": "",
            "activity": "",
            "wbs_element": "",
            "abs_att_type": "",
            "activity_type": "1410",
            "delete_flag": false,
            "reason": ""
        }

# Group Settings

## Settings list [/settings]
Shows all settings. This invokes the
RFC call **Z\_PBR\_PROFILE\_GETLIST**.

### Retrieve settings list[GET]

+ Parameters
    + id (optional, string) ... Id of the Setting, ABAP Name: **VARIANT**
    + description (optional, string) ... Description of the Setting, ABAP Name: **PROFILE_DESCR**
    + daytext (optional, string) ... Daytext indicator, ABAP Name: **DAYTEXT**
    + calendar (optional, string) ... Calendar indicator, ABAP Name: **CALENDAR**
    + sumrow (optional, bool) ... Sumrow field, ABAP Name: **SUMROW**
    + pertype (optional, number) ... Pertype field, ABAP Name: **PERTYPE**
    + firstdayof (optional, number) ... Firstdayof field, ABAP Name: **FIRSTDAYOF**
    + catsperiod (optional, number) ... Catsperiod indicator, ABAP Name: **CATSPERIOD**
    + type (optional, string) ... Indicator of absence and attendance type, ABAP Name: **DEF_ABS_ATT_TYPE**
    + is_default (optional, bool) ... Is default setting, ABAP Name: **IS_DEFAULT**

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        [
            {
                "id": "UCATSXT0",
                "description": "CATSXT: Non-productive activities (HR)",
                "daytext": false,
                "calendar": "",
                "sumrow": false,
                "pertype": "1",
                "firstdayof": 0,
                "catsperiod": 31,
                "type": "",
                "is_default": false
            },
            {
                "id": "UCATSXT1",
                "description": "CATSXT: Productive activities (HR/PS/CO)",
                "daytext": false,
                "calendar": "",
                "sumrow": false,
                "pertype": "1",
                "firstdayof": 0,
                "catsperiod": 31,
                "type": "",
                "is_default": false
            },
            ...
        ]

## Settings by setting id [/settings/:id]
Applies an id filter to the result of the **Z\_PBR\_PROFILE\_GETLIST** call.
This will return the specified setting, if it exists.

### Retrieve specific setting [GET]

+ Parameters
    + id (optional, string) ... Id of the Setting as specified in the URI, ABAP Name: **VARIANT**
    + description (optional, string) ... Description of the Setting, ABAP Name: **PROFILE_DESCR**
    + daytext (optional, string) ... Daytext indicator, ABAP Name: **DAYTEXT**
    + calendar (optional, string) ... Calendar indicator, ABAP Name: **CALENDAR**
    + sumrow (optional, bool) ... Sumrow field, ABAP Name: **SUMROW**
    + pertype (optional, number) ... Pertype field, ABAP Name: **PERTYPE**
    + firstdayof (optional, number) ... Firstdayof field, ABAP Name: **FIRSTDAYOF**
    + catsperiod (optional, number) ... Catsperiod indicator, ABAP Name: **CATSPERIOD**
    + type (optional, string) ... Indicator of absence and attendance type, ABAP Name: **DEF_ABS_ATT_TYPE**
    + is_default (optional, bool) ... Is default setting, ABAP Name: **IS_DEFAULT**

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {
            "id": "UCATSXT0",
            "description": "CATSXT: Non-productive activities (HR)",
            "daytext": false,
            "calendar": "",
            "sumrow": false,
            "pertype": "1",
            "firstdayof": 0,
            "catsperiod": 31,
            "type": "",
            "is_default": false
        }

# Group Timesheets

## Timesheets index route [/timesheets]
This route always returns an array of timesheets (can also be empty).

### Retrieve Timesheets [GET]
Invokes the RFC __Z\_PBR\_TIMESHEET_GET__. Fetches Timesheet data between a
time range, specified by the parameters `start_date` and `end_date`.

+ Parameters
    + start_date (optional, date) ... Start date of date range, ABAP Name: **IV_START_DATE**
    + end_date (optional, date) ... End date of date range, ABAP Name: **IV_END_DATE**
    + user_id (optional, string) ... Search only by specific user, ABAP Name: **IV_EMPLOYEE**

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        [
            {
                "counter": "000000002197",
                "status": "60",
                "status_text": "Cancelled",
                "user_id": 100190,
                "workdate": "2011-11-20T23:00:00.000Z",
                "hours_posted": 6,
                "hours_planned": 8,
                "unit": "H",
                "receiver_order": "800058",
                "network": "",
                "activity": "",
                "wbs_element": "",
                "abs_att_type": "0800",
                "activity_type": "1410",
                "delete_flag": false,
                "reason": ""
            },
            {
                "counter": "000000002200",
                "status": "60",
                "status_text": "Cancelled",
                "user_id": 100190,
                "workdate": "2011-11-20T23:00:00.000Z",
                "hours_posted": 4,
                "hours_planned": 8,
                "unit": "H",
                "receiver_order": "",
                "network": "904240",
                "activity": "0050",
                "wbs_element": "",
                "abs_att_type": "0800",
                "activity_type": "1410",
                "delete_flag": false,
                "reason": ""
            },
            ...
        ]

## Timesheet by id [/timesheets/:id]
A timesheet also has an id (inside the SAP system `counter`).
This also invokes __Z\_PBR\_TIMESHEET_GET__.

### Retrieve specific timesheet [GET]
Fetches the specified timesheet, if it exists.

+ Parameters
    + id (string) ... Id of the Timesheet, Abap Name: __COUNTER__

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {
            "counter": "000000002197",
            "status": "60",
            "status_text": "Cancelled",
            "user_id": 100190,
            "workdate": "2011-11-20T23:00:00.000Z",
            "hours_posted": 6,
            "hours_planned": 8,
            "unit": "H",
            "receiver_order": "800058",
            "network": "",
            "activity": "",
            "wbs_element": "",
            "abs_att_type": "0800",
            "activity_type": "1410",
            "delete_flag": false,
            "reason": ""
        }

### Delete specific timesheet [DELETE]
Deletes the specified timesheet, if the user has the needed rights.
This also invokes __Z\_PBR\_TIMESHEET_GET__.

+ Parameters
    + id (string) ... Id of the Timesheet, Abap Name: __COUNTER__

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {}

# Group Absence / Attendance Types

## Absence / Attendance Types index [/abs_att_types]
All methods on this route return an array of types (can also be empty).

### Get a list of Absence / Attendance types [GET]
Returns a list of all types. Invokes **Z_PBR_ABS_ATTEND_TYPE_GETLIST**.

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        [
            {
                "client": 800,
                "moabw": 10,
                "id": "0101",
                "end_date": "9999-12-30T23:00:00.000Z",
                "description": "Vacation",
                "indicator": "A"
            },
            {
                "client": 800,
                "moabw": 10,
                "id": "0425",
                "end_date": "9999-12-30T23:00:00.000Z",
                "description": "Instructor duty",
                "indicator": "P"
            },
            ...
        ]

## Absence / Attendance Types by id [/abs_att_types/:id]

### Retrieve specific Absence Attendance Type [GET]
Returns the specified type, if it exists. Invokes **Z_PBR_ABS_ATTEND_TYPE_GETLIST**.

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Parameters
    + id (string) ... Id of the type

+ Response 200

        {
            "client": 800,
            "moabw": 10,
            "id": "0101",
            "end_date": "9999-12-30T23:00:00.000Z",
            "description": "Vacation",
            "indicator": "A"
        }

# Group Activity Types

## Activity Types index [/activity_types]

### Get a list of Activity Types [GET]
Returns a list of activity types. Invokes **Z_PBR_ACTIVITY_TYPES_GETLIST**.

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Parameters
    + cost_center (string) ... Cost center of the activity type, ABAP Name: **IV_COSTCENTER**
    + controlling_area (string, optional) ... Controlling area of the type, ABAP Name: **IV_CO_AREA**

+ Response 200

        [
            {
                "id": "1409",
                "name": "Modification hours"
            },
            {
                "id": "1410",
                "name": "Repair Hours"
            },
            {
                "id": "1411",
                "name": "Routine work hours"
            },
            {
                "id": "1412",
                "name": "IT Services"
            },
            {
                "id": "1414",
                "name": "IT Services II"
            },
            {
                "id": "1420",
                "name": "Machine Hours"
            }
        ]

## Activity Types by id [/activity_types/:id]

### Retrieve specific activity type [GET]
Fetches the type with the specified id. Invokes **Z_PBR_ACTIVITY_TYPES_GETLIST**.

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Parameters
    + id (string) ... id of the activity type

# Group Company Codes

## Company Codes index [/company_codes]

### Retrieve list of company codes [GET]

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Parameters
    + id (string, optional) ... Id of the company code, ABAP Name: **IV_COMP_CODE**
    + name (string, optional) ... Name of the company code, ABAP Name: **IV_COMP_CODE_DESCR**
    + max_records (number, optional) ... Maximum number of records, ABAP Name: **IV_MAXRECORDS**

+ Response 200

        [
            {
                "id": "0001",
                "name": "SAP A.G."
            },
            {
                "id": "0005",
                "name": "IDES AG NEW GL"
            },
            {
                "id": "0006",
                "name": "IDES US INC New GL"
            },
            {
                "id": "0007",
                "name": "IDES AG NEW GL 7"
            },
            {
                "id": "0008",
                "name": "IDES US INC New GL 8"
            },
            ...
        ]

## Company Codes by id [/company_codes/:id]

### Retrieve specific company code [GET]

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Parameters
    + id (string) ... Id of the company code, ABAP Name: **IV_COMP_CODE**

+ Response 200

        {
            "id": "0001",
            "name": "SAP A.G."
        }