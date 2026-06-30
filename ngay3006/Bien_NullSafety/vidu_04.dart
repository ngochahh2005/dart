String moTa = "abcxyz";
String? moTa2;

// khai bao theo kieu lazy initialization
late String moTa3; // lat nua moi gan gia tri

void main() {
  // print(moTa3);
  moTa3 = 'Nguyen Van A';
  //moTa3 = null; // khong the gan gia tri null
  print(moTa3);
}
