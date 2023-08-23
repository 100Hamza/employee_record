class AddEmployee
{
  final int? id;
  final String? employeeName;
  final String? employeeNumber;

  AddEmployee({this.id , this.employeeName, this.employeeNumber});

  AddEmployee.fromMap(Map<String, dynamic> res):
        id = res['id'],
        employeeName = res['employeeName'],
        employeeNumber = res['employeeNumber'];
  Map<String, Object?> toMap()
  {
    return
        {
          'id' : id,
          'employeeName' : employeeName,
          'employeeNumber' : employeeNumber
        };
  }

}
