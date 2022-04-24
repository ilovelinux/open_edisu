Uri httpsEdisu(String path) {
  return Uri.https("edisuprenotazioni.edisu-piemonte.it:8443", path);
}

// Make a POST request with email and password fields
final signin = httpsEdisu('sbs/web/signin');

// Return user info
final me = httpsEdisu('sbs/web/me');

final studentBookingList = httpsEdisu('sbs/web/studentbookinglist');

// Return the list of the halls, needs type=0 (what is it?)
final hallList = httpsEdisu('sbs/web/halllist');
final halllistMobile = httpsEdisu('sbs/booking/halllist'); // {city_id: "1"}

// Return the hall's slots, needs date (yyyy-mm-dd) and hall name
final slots = httpsEdisu('sbs/web/student/slots');

final seats = httpsEdisu('sbs/web/student/seats');

// hall_id=1&date=dd-mm-yyyy
// returned values are already-booked seats
final bookingsPerSeat = Uri.https(
    "edisuprenotazioni.edisu-piemonte.it", 'sbs/booking/bookingsperseats');

final customSlotBook = httpsEdisu("sbs/booking/custombooking");

final bookingCancel = httpsEdisu('sbs/web/bookingcancel'); // booking_id=376344
