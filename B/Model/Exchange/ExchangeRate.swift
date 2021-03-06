//
//  ViewController.swift
//  monPtiBaluchon
//
//  Created by Aurélien Waxin on 25/11/2021.
//

import Foundation
// MARK: - Welcome
struct ExchangeResponse: Decodable {
    let timestamp: Int
    let base : String
    let rates: [String: Double]
}

// MARK: JSON Response
//{
//  "success":true,
//  "timestamp":1639424044,
//  "base":"EUR",
//  "date":"2021-12-13",
//  "rates":{
//    "AED":4.147407,
//    "AFN":117.431358,
//    "ALL":120.933144,
//    "AMD":558.556458,
//    "ANG":2.035126,
//    "AOA":631.399167,
//    "ARS":114.84188,
//    "AUD":1.582684,
//    "AWG":2.033034,
//    "AZN":1.923069,
//    "BAM":1.958892,
//    "BBD":2.280014,
//    "BDT":96.881475,
//    "BGN":1.954931,
//    "BHD":0.425658,
//    "BIF":2259.428966,
//    "BMD":1.12915,
//    "BND":1.543947,
//    "BOB":7.785942,
//    "BRL":6.402733,
//    "BSD":1.12919,
//    "BTC":2.4485857e-5,
//    "BTN":85.555922,
//    "BWP":13.238285,
//    "BYN":2.860835,
//    "BYR":22131.338201,
//    "BZD":2.276208,
//    "CAD":1.444353,
//    "CDF":2259.428348,
//    "CHF":1.040845,
//    "CLF":0.034422,
//    "CLP":949.796361,
//    "CNY":7.1893,
//    "COP":4388.441118,
//    "CRC":720.992905,
//    "CUC":1.12915,
//    "CUP":29.922473,
//    "CVE":110.825987,
//    "CZK":25.403277,
//    "DJF":200.6726,
//    "DKK":7.435786,
//    "DOP":64.192612,
//    "DZD":157.178757,
//    "EGP":17.737931,
//    "ERN":16.937337,
//    "ETB":54.594299,
//    "EUR":1,
//    "FJD":2.40399,
//    "FKP":0.851807,
//    "GBP":0.854287,
//    "GEL":3.494658,
//    "GGP":0.851807,
//    "GHS":6.904717,
//    "GIP":0.851807,
//    "GMD":59.283808,
//    "GNF":10501.093649,
//    "GTQ":8.734352,
//    "GYD":236.234475,
//    "HKD":8.80983,
//    "HNL":27.404426,
//    "HRK":7.520421,
//    "HTG":113.549997,
//    "HUF":367.584616,
//    "IDR":16174.338488,
//    "ILS":3.517674,
//    "IMP":0.851807,
//    "INR":85.611902,
//    "IQD":1648.558866,
//    "IRR":47706.583888,
//    "ISK":147.568433,
//    "JEP":0.851807,
//    "JMD":174.78106,
//    "JOD":0.800516,
//    "JPY":128.146656,
//    "KES":127.537393,
//    "KGS":95.750899,
//    "KHR":4598.462421,
//    "KMF":492.168224,
//    "KPW":1016.23483,
//    "KRW":1337.619211,
//    "KWD":0.342022,
//    "KYD":0.941092,
//    "KZT":492.720142,
//    "LAK":12448.87816,
//    "LBP":1725.74004,
//    "LKR":228.102484,
//    "LRD":159.944271,
//    "LSL":18.077352,
//    "LTL":3.334086,
//    "LVL":0.683011,
//    "LYD":5.199766,
//    "MAD":10.441816,
//    "MDL":19.967051,
//    "MGA":4479.897868,
//    "MKD":61.712826,
//    "MMK":2010.011835,
//    "MNT":3227.544769,
//    "MOP":9.07128,
//    "MRO":403.106323,
//    "MUR":49.287682,
//    "MVR":17.392258,
//    "MWK":925.903184,
//    "MXN":23.698613,
//    "MYR":4.770094,
//    "MZN":72.073269,
//    "NAD":18.0775,
//    "NGN":463.182258,
//    "NIO":39.774333,
//    "NOK":10.206781,
//    "NPR":136.888994,
//    "NZD":1.670335,
//    "OMR":0.434748,
//    "PAB":1.12929,
//    "PEN":4.579822,
//    "PGK":3.980271,
//    "PHP":56.842562,
//    "PKR":200.988985,
//    "PLN":4.639025,
//    "PYG":7704.913691,
//    "QAR":4.111177,
//    "RON":4.949632,
//    "RSD":117.594742,
//    "RUB":83.03319,
//    "RWF":1137.618533,
//    "SAR":4.236112,
//    "SBD":9.131896,
//    "SCR":16.689555,
//    "SDG":493.999551,
//    "SEK":10.264272,
//    "SGD":1.544254,
//    "SHP":1.555291,
//    "SLL":12682.61196,
//    "SOS":660.552347,
//    "SRD":24.320814,
//    "STD":23371.123355,
//    "SVC":9.881445,
//    "SYP":2836.980995,
//    "SZL":18.077161,
//    "THB":37.736695,
//    "TJS":12.746761,
//    "TMT":3.952025,
//    "TND":3.248003,
//    "TOP":2.578358,
//    "TRY":15.596606,
//    "TTD":7.666353,
//    "TWD":31.410124,
//    "TZS":2602.690127,
//    "UAH":30.396253,
//    "UGX":4019.983401,
//    "USD":1.12915,
//    "UYU":49.928145,
//    "UZS":12251.276385,
//    "VEF":241446375923.44458,
//    "VND":25947.86489,
//    "VUV":127.879223,
//    "WST":2.935983,
//    "XAF":656.998462,
//    "XAG":0.050585,
//    "XAU":0.000632,
//    "XCD":3.051584,
//    "XDR":0.808882,
//    "XOF":654.90725,
//    "XPF":119.689679,
//    "YER":282.56977,
//    "ZAR":18.088969,
//    "ZMK":10163.70097,
//    "ZMW":18.264749,
//    "ZWL":363.58581
//  }
//}
