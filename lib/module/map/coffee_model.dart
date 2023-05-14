
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coffee {
  String shopName;
  String address;
  String thumbNail;
  LatLng locationCoords;

  Coffee(
      {required this.shopName,
        required this.address,
        required this.thumbNail,
        required this.locationCoords});
}

final List<Coffee> coffeeShops = [
  Coffee(


      shopName: '3omr Afndi',
      address: '',
      locationCoords: LatLng(30.555437607761792, 31.011232500319238),
      thumbNail: 'https://lh3.googleusercontent.com/EqKjOoU7wcEjRzBYi9c1Kz3lJC6rXyBWlZrtEz_VoYtxhJdgHcs59WiVkdTEiV685paGVPKEUeRqaObiWWuuOMyi3FGobfe7otWRQ8m2G7kgH86LTPZZjLUK--WenZi9a-E9bMnMWfmXVpp5LLnTNQZeFpjpMMzFq-CpNc4U2m4z-LvE5JdtFHsCuSgFiKB-JrQPEzYaV4QCrE9NPRzA_q0FIjce3143UncYKOOCd2SWmz0dKJSkGrwgN-1WnU0hiIye0Hx-XLZ2pS8Ic5mDa9zbmReQzmFp22DTJXqPlFNgykxDXZlEkz5y19zn9mXRjk-I4uBXq_I46mJgYRnMBkKGKGkSPuUMArYXIwGsUfQpSMfqaUTWxQMM9ltt_f5KQPENOkUP6LB5a6B9a6uu2nI2q-FUnmk_Yr2NLfphTrlJHgTVv3_wLjoylMhTYufGBEKf_NZLzQaNxC5w1A_RU3GvLbVb6z-T3X_PRbhb1P2X2RbaK84zNETA9vAuaPPVirgk6a3E9cqBGIKQUuPN3URBVqJOR32gHh0jwad4rczoIoBoS7ASSN4R8Ruj8IstXkQ40L-3ljwlKBxa9vtwReUHn1_9dY-eBj1Kk9__wbaFvHC5eWp5FzUVPSUC8B8FC5OAO-6oYFHllwAaGZYEBYwkQHwyWplD1HfLslWcIBT2iP4ZctdQsVnzX_NwAcCL5zETH_8NGdlPJ9hH-ygtzBu20Iw7HQVlUWKynCNRX_ujR6X4D249GqtwuF_a-C8=w1717-h830-no?authuser=0'
  ),
  Coffee(
      shopName: 'FCI',
      address: '',
        locationCoords: LatLng(30.57573001035425, 31.00850917669374),
      thumbNail: 'https://lh3.googleusercontent.com/uf6loASJARml1AqMcnG2Uwb0EBP--9lubvNWG_EosQGsFbQgG47pq44OYSwsXWVBbQ_OD57eZi616Uw7olPbC8e39w2dt0V7gvHsNwYzmGfZiZT0k4jlx1_UWGzvGRr4lh1vR6EUirfx0AYKg8KNTypQkNrKDxcCRZO-fxmsXVcjpzQy-rjhv_SZJ6ItqGt_eFkomqfQrb6iJruDKHJXD-uG-Wshvp5ka0AG1-lSoNi_dB61ESNilghZQPkh9XvKbK7ujm99ibYQR3KKyKLmCmhO3Y6Ai2AH983XqaxoJ_-ll2EzGtzyi7vipHdGsrvvPHps0-tw0EogdH4whhNaVZrxLY7VNTqjEtjmYpnVrJVto0WgPQS0iRmBmoCatbLuzzthmJ57cHKGHVaqe25SMsS90Eo18tktDUhJThusl6G5m9EsIMtfF3ZOV5Jec9p-WYMXg4_5wV-anN8dKSj8yEhjkhCBE96n5joAV6dgWhU_f1XHlCqe5-pHSisgJZ637UhcgZMvNp-vHG8m7iQonSFwc6gJPklMBq47Eu3-dX9shMCR19icvA_1t2FTbhUiSUOGIundNAUMU5zDpsjtsxVqy_52VsHB4RtwAkNZakkVmbZjVNdBMI7Nq-mWEImX19VV4Z-EZeH3QbO1K8At-igTfE3Uea7rlO-itZNJTJ98_yQtteq5l3TBLwc852OCRHLj_WYIpjlpNXz8Lfupf00CtL308zzsNiq5GbJt7lsbQmx-rLV8TRlWewT9jTs=w1264-h830-no?authuser=0'
  )
];