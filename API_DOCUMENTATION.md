# LMS Mobile API Documentation

## Base Information
- **Base URL**: `https://your-domain.com/api/user`
- **Authentication**: Bearer Token
- **Header**: `Authorization: Bearer {access_token}`
- **Content-Type**: `application/json`

---

## Authentication Endpoints

### 1. Login
**POST** `/auth/login`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| username | string | Yes | Username or email |
| password | string | Yes | Password |

**Request:**
```json
{
  "username": "student001",
  "password": "password123"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "token": "eyJ0eXAiOiJKV1QiLCJhb...",
    "refresh_token": "dGhpcyBpcyByZWZyZXNo...",
    "user": {
      "id": 1,
      "role": "student",
      "firstname": "John",
      "lastname": "Doe"
    }
  }
}
```

### 2. Logout
**POST** `/auth/logout`
- Auth Required: Yes

### 3. Change Password
**POST** `/auth/changepass`

| Parameter | Type | Required |
|-----------|------|----------|
| current_pass | string | Yes |
| new_pass | string | Yes |
| confirm_pass | string | Yes |

---

## Student Core Endpoints

### 4. Dashboard
**GET** `/user/dashboard`
- Auth Required: Yes

**Response:**
```json
{
  "status": "success",
  "data": {
    "attendence_percentage": 85,
    "homeworklist": [],
    "notificationlist": [],
    "subjects_data": {},
    "timetable": {},
    "visitor_list": [],
    "bookList": [],
    "teacherlist": []
  }
}
```

### 5. Profile
**GET** `/user/profile`
- Auth Required: Yes

### 6. Fees
**GET** `/user/fees`
- Auth Required: Yes

**GET** `/user/getfees`
- Auth Required: Yes

---

## Academic Endpoints

### 7. Attendance
**GET** `/attendence`
- Auth Required: Yes

**GET** `/attendence/getAttendence?start=2024-01-01&end=2024-01-31`
- Auth Required: Yes

**POST** `/attendence/getdaysubattendence`
- Auth Required: Yes
- Body: `{ "date": "2024-01-15" }`

### 8. Marks
**GET** `/mark/marklist`
- Auth Required: Yes

### 9. Homework
**GET** `/homework`
- Auth Required: Yes

**GET** `/homework/homework_detail/{id}/{status}`
- Auth Required: Yes

**POST** `/homework/upload_docs`
- Auth Required: Yes
```json
{
  "homework_id": 1,
  "message": "Homework completed",
  "file": "file"
}
```

### 10. Timetable
**GET** `/timetable`
- Auth Required: Yes

### 11. Subjects
**GET** `/subject`
- Auth Required: Yes

### 12. Syllabus
**GET** `/syllabus`
- Auth Required: Yes

**GET** `/syllabus/status`
- Auth Required: Yes

---

## Communication Endpoints

### 13. Teachers
**GET** `/teacher`
- Auth Required: Yes

**POST** `/teacher/rating`
- Auth Required: Yes
```json
{
  "staff_id": 1,
  "comment": "Great teacher",
  "rate": 5,
  "user_id": 1,
  "role": "student"
}
```

### 14. Notifications
**GET** `/notification`
- Auth Required: Yes

**POST** `/notification/updatestatus`
- Auth Required: Yes
```json
{
  "notification_id": 1
}
```

### 15. Chat
**GET** `/chat/myuser`
- Auth Required: Yes

**POST** `/chat/getChatRecord`
- Auth Required: Yes
```json
{
  "chat_connection_id": 1
}
```

**POST** `/chat/newMessage`
- Auth Required: Yes
```json
{
  "chat_connection_id": 1,
  "chat_to_user": 2,
  "message": "Hello",
  "time": "10:30 AM"
}
```

### 16. Apply Leave
**GET** `/apply_leave`
- Auth Required: Yes

**POST** `/apply_leave/add`
- Auth Required: Yes
```json
{
  "apply_date": "2024-01-20",
  "from_date": "2024-01-25",
  "to_date": "2024-01-27",
  "message": "Medical leave"
}
```

---

## Other Services

### 17. Library
**GET** `/book`
**GET** `/book/issue`

### 18. Transport
**GET** `/route`

### 19. Content/Downloads
**GET** `/content/list`
**GET** `/content/assignment`
**GET** `/content/studymaterial`

### 20. Examination
**GET** `/exam`
**GET** `/exam/examresult`
**GET** `/examschedule`

### 21. Visitors
**GET** `/visitors`

### 22. Calendar
**GET** `/calendar`
**GET** `/calendar/getevents`

### 23. Timeline
**POST** `/timeline/add`

### 24. Online Exam
**GET** `/onlineexam`
**POST** `/onlineexam/submit`

### 25. Payment
**GET** `/offlinepayment`
**POST** `/offlinepayment/add`

### 26. Video Tutorials
**GET** `/video_tutorial`

### 27. Hostel
**GET** `/hostel`

---

## HTTP Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Server Error |

---

## Response Format

### Success Response
```json
{
  "status": "success",
  "data": { ... },
  "message": "Success message"
}
```

### Error Response
```json
{
  "status": "error",
  "message": "Error message",
  "errors": { ... }
}
```

---

## Example API Calls

### cURL Examples

```bash
# Login
curl -X POST "https://your-domain.com/api/user/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username":"student001","password":"password123"}'

# Get Dashboard
curl -X GET "https://your-domain.com/api/user/user/dashboard" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"

# Get Fees
curl -X GET "https://your-domain.com/api/user/user/getfees" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

### JavaScript (Fetch)

```javascript
// Login
const login = async () => {
  const response = await fetch('https://your-domain.com/api/user/auth/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username: 'student001', password: 'password123' })
  });
  const data = await response.json();
  return data.data.token;
};

// Get Dashboard
const getDashboard = async (token) => {
  const response = await fetch('https://your-domain.com/api/user/user/dashboard', {
    headers: { 'Authorization': `Bearer ${token}` }
  });
  return await response.json();
};
```

### Android (Retrofit)

```java
// API Service
public interface ApiService {
    @POST("auth/login")
    Call<LoginResponse> login(@Body LoginRequest request);
    
    @GET("user/dashboard")
    Call<DashboardResponse> getDashboard(@Header("Authorization") String token);
}
```

### iOS (Swift)

```swift
// Login
func login(username: String, password: String) {
    let url = URL(string: "https://your-domain.com/api/user/auth/login")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body = ["username": username, "password": password]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle response
    }.resume()
}
```
