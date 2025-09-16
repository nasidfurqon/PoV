class VisitData{
  List<Map<String, dynamic>> taskData =[
    {
      'person': 'demo1',
      'place': 'Jakarta Office Building',
      'status': 'high',
      'street': 'Jl. Sudirman No. 123',
      'deadline': '20/1/2024',
      'city': 'Jakarta',
      'hourFrom': '09:00',
      'hourTo': '10:00',
      'statusVisit': 'Aktif',
      'targetLocation': {
        'lat': '-6.208700',
        'long': '106.845700'
      },
      'radius': '50',
      'description': 'Routine inspection and maintenance check',
      'progress': 'Menunggu',
      'visitor': 'Tes',
      'statusJadwal': 'Selesai',
      'score': '95',
      'isCompleted': false
    },
    {
      'person': 'demo2',
      'statusVisit': 'Aktif',
      'place': 'Bandung Office Building',
      'status': 'normal',
      'street': 'Jl. Sudirman No. 123',
      'city': 'Bandung',
      'targetLocation': {
        'lat': '-6.208700',
        'long': '106.845700'
      },
      'deadline': '20/1/2024',
      'hourFrom': '09:00',
      'hourTo': '10:00',
      'score': '95',
      'radius': '50',
      'description': 'Routine inspection and maintenance check',
      'progress': 'Berlangsung',
      'statusJadwal': 'Selesai',
      'visitor': 'Tes',
      'isCompleted': false
    },
    {
      'place': 'Jakarta Office Building',
      'status': 'high',
      'street': 'Jl. Sudirman No. 123',
      'city': 'Jakarta',
      'score': '95',
      'deadline': '20/1/2024',
      'hourFrom': '09:00',
      'hourTo': '10:00',
      'statusJadwal': 'Terjadwal',
      'targetLocation': {
        'lat': '-6.208700',
        'long': '106.845700'
      },
      'radius': '50',
      'statusVisit': 'Maintenance',
      'person': 'demo3',
      'description': 'Routine inspection and maintenance check',
      'visitor': 'Tes',
      'progress': 'Selesai',
      'isCompleted': true
    }
  ];
}