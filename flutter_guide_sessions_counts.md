# Flutter Update Guide: Recurring Bookings & Dynamic Agora Tokens

This guide summarizes the changes you need to implement in your Flutter application to support the new backend features.

## 1. Creating a Booking (Multiple Sessions)
When a student wants to book more than one session (e.g., a recurring weekly lesson), you simply need to add the `total_sessions` field to your booking request.

**Endpoint:** `POST /api/student/booking`

**Updated Request Body:**
```json
{
  "teacher_id": 12,
  "service_id": 5,
  "timeslot_id": 105,
  "type": "single", 
  "total_sessions": 4, // <--- ADD THIS FIELD
  "special_requests": "Optional notes"
}
```
> [!TIP]
> Even if you send `"type": "single"`, if `total_sessions` is > 1, the backend will automatically convert it to a **package** and calculate the price correctly for you.

---

## 2. Dynamic Agora Tokens (CRITICAL)
The backend no longer saves Agora tokens in the `join_url` or `host_url` because tokens expire every 24 hours. You must now fetch fresh tokens immediately before entering a call.

### A. For Students (Joining)
Call this endpoint when the student clicks the "Join Session" button:
- **Endpoint:** `POST /api/student/sessions/{session_id}/join`
- **Response:**
  ```json
  {
    "success": true,
    "data": {
      "agora": {
        "channel": "session_123",
        "token": "REALLY_LONG_DYNAMIC_TOKEN_STRING",
        "uid": "student_45",
        "role": "participant",
        "expires_in": 3600
      }
    }
  }
  ```
- **Flutter Action:** Pass the `channel` and `token` from this response into your Agora SDK `joinChannel` method.

### B. For Teachers (Starting)
Call this endpoint when the teacher clicks the "Start Session" button:
- **Endpoint:** `POST /api/teacher/sessions/{session_id}/start`
- **Response:**
  ```json
  {
    "success": true,
    "data": {
      "agora": {
        "channel": "session_123",
        "token": "REALLY_LONG_DYNAMIC_TOKEN_STRING",
        "uid": "teacher_12",
        "role": "host"
      }
    }
  }
  ```

---

## 3. UI Changes & Notifications
- **Sessions List**: After a user pays for a "4 Sessions" booking, your app's "My Sessions" screen will now automatically show 4 separate session records, each scheduled 7 days apart.
- **Notifications**: You don't need to change anything here; the backend will automatically send the updated Push/SMS messages to the student and teacher with the specific dates and session count.

## Summary Checklist for Flutter
- [ ] Add `total_sessions` field to the Booking model/request.
- [ ] Logic Update: Instead of reading `join_url` from the initial booking response, call the `/join` or `/start` API to get the token right before triggering the Agora view.
- [ ] Pass the new `token` and `channel` from the API response into the Agora SDK.
