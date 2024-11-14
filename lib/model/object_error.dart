class ObjectError{
  final status;
  final message;

  ObjectError({required this.status,required this.message});
  factory ObjectError.fromJson(Map<String, dynamic> json){
    return ObjectError(
      status: json['status'],
      message: json['message']
    );
  }
}