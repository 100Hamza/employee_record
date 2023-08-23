class EmployeeAuthModel
{
  final int? id;
  final String? employeeName;
  final String? employeeNumber;
  final String? employeeImage;
  final String? employeeAuthDate;
  final String? employeeAuthTime;
  final String? authStatus;

  EmployeeAuthModel({this.id , this.employeeName, this.employeeNumber , this.employeeImage , this.employeeAuthDate, this.employeeAuthTime, this.authStatus});

  EmployeeAuthModel.fromMap(Map<String, dynamic> res):
        id = res['id'],
        employeeName = res['employeeName'],
        employeeNumber = res['employeeNumber'],
        employeeImage = res['employeeImage'],
        employeeAuthDate = res['employeeAuthDate'],
        employeeAuthTime = res['employeeAuthTime'],
        authStatus = res['authStatus'];
  Map<String, Object?> toMap()
  {
    return
      {
        'id' : id,
        'employeeName' : employeeName,
        'employeeNumber' : employeeNumber,
        'employeeImage' : employeeImage,
        'employeeAuthDate' : employeeAuthDate,
        'employeeAuthTime' : employeeAuthTime,
        'authStatus' : authStatus
      };
  }

}
