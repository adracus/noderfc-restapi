# SAP Timesheets API
This API offers a wrapper around various RFC calls concerning time sheets and
time recording. It uses basic auth and HTTPS for authentication. For
performance, only the first time you try to get information from the API,
the api stores your data on the API server. In order to clear that data,
please logout after the API usage (`/logout` route)

# API Information [/]
This group has currently only one route and represents information about the
API.

## API Information [GET]
Shows the version of this API as well as the number of currently logged on
users and the available (in express registered) routes.

+ Response 200 (application/json)

        {
          "name": "Activity Recording",
          "version": "0.0.2",
          "no_of_current_users": 0,
          "routes": [
            "GET /",
            "GET /logout",
            "GET /user/me",
            "GET /user/me/settings",
            "GET /user/me/settings/:id",
            "GET /user/me/timesheet",
            "GET /user/me/activity_types",
            "GET /user/:id/timesheet",
            "GET /timesheets",
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
            "GET /reeciver_orders",
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

## User Personal info [/user/me]
Shows the info about the user again that also was shown during login.
This route does not invoke an RFC call.

### Retrieve User personal information [GET]

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

        {
            "token": 1,
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

## User Settings [/user/me/settings]
Shows all settings of the currently logged in user. This invokes the
RFC call **Z\_PBR\_PROFILE\_GETLIST**.

### Retrieve User settings [GET]

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

## User settings by setting id [/user/me/settings/:id]
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

## User timesheet [/user/me/timesheet]
Returns the timesheet for the current user.

### Retrieve the timesheet [GET]

+ Parameters
    + start_date (optional, date) ... Start date of the timesheet
    + end_date (optional, date) ... End date of the timesheet

+ Request (application/json)

    + Headers

         Authorization: Basic SFJQQl9FTVBMMDE6d2VsY29tZQ==

+ Response 200

    {
        "daily": [
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
        ],
        "aggregated": [
            {
                "employee_id": 100190,
                "employee_last_name": "Sanson",
                "employee_first_name": "John",
                "total_planned": 24,
                "total_posted": 49,
                "total_approved": 0,
                "total_rejected": 0,
                "unit": "H"
            }
        ]
    }