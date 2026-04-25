# Online Admission API Guide

## Overview
The Online Admission API allows parents/students to submit admission applications through a mobile app. The form fields are dynamic and controlled by the school admin.

---

## Public Endpoints (No Auth Required)

### 1. Check Admission Status
```
GET /api/admission
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "enabled": true,
    "instructions": "Please fill out the admission form...",
    "conditions": "Terms and conditions text...",
    "amount": 500,
    "payment_enabled": true
  }
}
```

---

### 2. Get Form Configuration
```
GET /api/admission/form_config
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "fields": {
      "middlename": "Middle Name",
      "lastname": "Last Name",
      "category": "Category",
      "religion": "Religion",
      "cast": "Caste",
      "mobile_no": "Mobile Number",
      "student_email": "Email",
      ...
    },
    "enabled_fields": ["middlename", "lastname", "category", ...],
    "gender_list": ["Male", "Female", "Other"],
    "class_list": [
      {"id": 1, "class": "Class 1"},
      {"id": 2, "class": "Class 2"}
    ],
    "category_list": [
      {"id": 1, "category": "General"},
      {"id": 2, "category": "OBC"}
    ],
    "blood_group_list": ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
    "house_list": [
      {"id": 1, "house_name": "Red House"},
      {"id": 2, "house_name": "Blue House"}
    ],
    "custom_fields": [...]
  }
}
```

---

### 3. Get Available Classes
```
GET /api/admission/classes
```

**Response:**
```json
{
  "status": "success",
  "data": [
    {"id": 1, "class": "Class 1"},
    {"id": 2, "class": "Class 2"},
    {"id": 3, "class": "Class 3"}
  ]
}
```

---

### 4. Get Sections by Class
```
GET /api/admission/sections?class_id=1
```

**Response:**
```json
{
  "status": "success",
  "data": [
    {"id": 1, "section": "Section A"},
    {"id": 2, "section": "Section B"}
  ]
}
```

---

### 5. Submit Admission Form
```
POST /api/admission/submit
Content-Type: application/json

{
  "firstname": "John",
  "lastname": "Doe",
  "dob": "2015-01-15",
  "gender": "male",
  "class_id": 1,
  "section_id": 1,
  "email": "parent@email.com",
  "mobileno": "9876543210",
  "father_name": "James Doe",
  "father_phone": "9876543211",
  "mother_name": "Jane Doe",
  "guardian_is": "father",
  "guardian_name": "James Doe",
  "guardian_relation": "father",
  "guardian_phone": "9876543211",
  "category": 1,
  "religion": "Hindu",
  "current_address": "123 Main St, City",
  "permanent_address": "123 Main St, City",
  "school_house_id": 1,
  "blood_group": "A+"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "admission_id": 123,
    "reference_no": 456789,
    "message": "Registration successful. Please note your reference number for further communication."
  }
}
```

---

### 6. Check Application Status
```
GET /api/admission/status?reference_no=456789
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "reference_no": "456789",
    "firstname": "John",
    "lastname": "Doe",
    "form_status": "submitted",
    "paid_status": "pending",
    "submitted_date": "2024-04-19"
  }
}
```

---

## Mobile App Form Guide

### Form Flow

1. **Initial Screen** - Call `/api/admission` to check if admission is open

2. **Form Setup** - Call `/api/admission/form_config` to get:
   - Which fields are enabled
   - Available options (classes, sections, categories, etc.)

3. **Class Selection** - User selects class, then call `/api/admission/sections?class_id=X`

4. **Form Display** - Build form using enabled fields:
   
   **Required Fields (Always shown):**
   - First Name (text)
   - Date of Birth (date picker)
   - Gender (dropdown: Male/Female/Other)
   - Class (dropdown from class_list)
   - Section (dropdown from sections API)

   **Optional Fields (Show only if enabled):**
   - Middle Name, Last Name
   - Email, Mobile Number
   - Category (dropdown)
   - Religion, Caste
   - Current/Permanent Address
   - Father Details (Name, Phone, Occupation)
   - Mother Details (Name, Phone, Occupation)
   - Guardian Details (if guardian_is enabled)
   - Bank Details (Account No, Bank Name, IFSC)
   - Blood Group, House
   - RTE, Previous School

5. **Submission** - POST to `/api/admission/submit`

6. **Confirmation** - Show reference number to user

---

## Recommended Form Layout

### Step 1: Student Information
```
┌─────────────────────────────────┐
│  Student Information            │
├─────────────────────────────────┤
│  First Name *                    │
│  [________________________]     │
│                                 │
│  Middle Name                    │
│  [________________________]     │
│                                 │
│  Last Name                      │
│  [________________________]     │
│                                 │
│  Date of Birth *                │
│  [📅 Select Date]             │
│                                 │
│  Gender *                      │
│  [○ Male ○ Female ○ Other]     │
└─────────────────────────────────┘
```

### Step 2: Academic Details
```
┌─────────────────────────────────┐
│  Academic Details              │
├─────────────────────────────────┤
│  Class *                        │
│  [Select Class__________▼]      │
│                                 │
│  Section *                      │
│  [Select Section______▼]       │
└─────────────────────────────────┘
```

### Step 3: Parent/Guardian Information
```
┌─────────────────────────────────┐
│  Parent Information            │
├─────────────────────────────────┤
│  Father's Name                 │
│  [________________________]     │
│                                 │
│  Father's Phone                │
│  [________________________]     │
│                                 │
│  Father's Occupation           │
│  [________________________]     │
│                                 │
│  Mother's Name                 │
│  [________________________]     │
│                                 │
│  Mother's Phone                │
│  [________________________]     │
└─────────────────────────────────┘
```

### Step 4: Contact & Address
```
┌─────────────────────────────────┐
│  Contact & Address              │
├─────────────────────────────────┤
│  Email *                        │
│  [________________________]     │
│                                 │
│  Mobile Number                  │
│  [________________________]     │
│                                 │
│  Current Address               │
│  [________________________]     │
│  [________________________]     │
│                                 │
│  ☐ Same as current address    │
│                                 │
│  Permanent Address            │
│  [________________________]     │
│  [________________________]     │
└─────────────────────────────────┘
```

---

## Admin API Endpoints (Authentication Required)

### 1. List All Admissions
```
GET /api/admin/admission/list
Headers: Authorization: Bearer <token>
```

**Query Parameters:**
- `status` - filter by status (submitted, approved, rejected)
- `class_id` - filter by class
- `search` - search by name/reference

**Response:**
```json
{
  "status": "success",
  "data": [
    {
      "id": 123,
      "reference_no": "456789",
      "firstname": "John",
      "lastname": "Doe",
      "dob": "2015-01-15",
      "gender": "male",
      "class": "Class 1",
      "section": "Section A",
      "father_name": "James Doe",
      "mobileno": "9876543210",
      "email": "parent@email.com",
      "form_status": "submitted",
      "paid_status": "pending",
      "submitted_date": "2024-04-19"
    }
  ]
}
```

### 2. Get Admission Details
```
GET /api/admin/admission/view/123
Headers: Authorization: Bearer <token>
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "id": 123,
    "reference_no": "456789",
    "admission_no": "",
    "firstname": "John",
    "middlename": "",
    "lastname": "Doe",
    "dob": "2015-01-15",
    "gender": "male",
    "email": "parent@email.com",
    "mobileno": "9876543210",
    "class": "Class 1",
    "section": "Section A",
    "category": "General",
    "religion": "Hindu",
    "father_name": "James Doe",
    "father_phone": "9876543211",
    "father_occupation": "Engineer",
    "mother_name": "Jane Doe",
    "mother_phone": "9876543212",
    "mother_occupation": "Teacher",
    "guardian_is": "father",
    "guardian_name": "James Doe",
    "guardian_relation": "father",
    "guardian_phone": "9876543211",
    "guardian_email": "father@email.com",
    "current_address": "123 Main St",
    "permanent_address": "123 Main St",
    "bank_account_no": "",
    "bank_name": "",
    "ifsc_code": "",
    "blood_group": "A+",
    "school_house_id": 1,
    "form_status": "submitted",
    "paid_status": "pending",
    "submitted_date": "2024-04-19"
  }
}
```

### 3. Update Admission Status
```
POST /api/admin/admission/update
Headers: Authorization: Bearer <token>
Content-Type: application/json

{
  "id": 123,
  "form_status": "approved",
  "admission_no": "ADM/2024/001",
  "remark": "Admission approved"
}
```

### 4. Delete Admission
```
POST /api/admin/admission/delete
Headers: Authorization: Bearer <token>
Content-Type: application/json

{
  "id": 123
}
```

---

## Status Values

| Status | Description |
|--------|-------------|
| `submitted` | Application just submitted |
| `approved` | Approved by admin |
| `rejected` | Rejected by admin |
| `pending` | Waiting for action |

| Paid Status | Description |
|------------|-------------|
| `pending` | Payment not received |
| `paid` | Payment received |
| `failed` | Payment failed |