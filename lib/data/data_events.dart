import 'package:ticket_app/models/event_model.dart';

List<CategoryModel> eventCategories = <CategoryModel>[
  CategoryModel(value: 'Umum', logoSource: 'assets/commercial_48px.png'),
  CategoryModel(value: 'WorkShop', logoSource: 'assets/meeting_room_48px.png'),
  CategoryModel(value: 'Bioskop', logoSource: 'assets/movie_ticket_48px.png'),
  CategoryModel(value: 'Konser', logoSource: 'assets/metal_music_48px.png'),
  CategoryModel(value: 'Seminar', logoSource: 'assets/training_48px.png'),
  CategoryModel(value: 'Festival', logoSource: 'assets/carousel_48px.png'),
];

List<EventModel> events = <EventModel>[
  EventModel(
      eventName: 'Halal Bihalal Alun Alun',
      eventDescription:
          'Est duis consequat duis labore consectetur aliqua aliquip occaecat ex non nulla nisi. Duis sint deserunt nulla amet laboris. Consectetur tempor nostrud sunt laboris fugiat ea.',
      eventDate: '21 Februari 2021',
      eventTime: '07-00 - 08-40',
      eventCategory: 'Umum',
      popularity: 33,
      eventAddress: 'Jl Bhayangkara',
      ticketStock: 5,
      ticketPrice: 25000,
      mainImage:
          'https://www.goodnewsfromindonesia.id/uploads/post/large-halal-bi-halal-dwi-prasetya-1075e0110668e870fff8bc1aaf24ad66.jpg',
      imageURLs: <String>[
        'https://3.bp.blogspot.com/-jdILW-VPjg4/V4WqHgP-4XI/AAAAAAAAECM/jmT-lo4_w2Us41PU3UiaojUy4mFPWMl-ACLcB/w1200-h630-p-k-no-nu/Halal%2BBihalal%2BBodas%2BPakembaran.jpg',
        'https://i1.wp.com/www.islampos.com/wp-content/uploads/2017/06/salam-shalat-halal-bihalal-.jpg?resize=600%2C375&ssl=1',
        'https://4.bp.blogspot.com/-Mw-q82HydCY/XGUyS-kXqZI/AAAAAAAAAGs/5mOx5fstJ4Y3b26im_jZWABTCrPYY032QCLcBGAs/w1200-h630-p-k-no-nu/ccccc.jpg',
        'https://4.bp.blogspot.com/-VLVS4CVA6Ps/V3jqrl4lhPI/AAAAAAAAACU/6zbi_5Nd8aARHejde19DoPqP2df0tEiDQCLcB/s1600/Halal%2BBi%2BHalal%2BWS%2BPamungkas%2BIndonesia.jpg'
      ]),
  EventModel(
      eventName: 'Konser Limbad',
      eventDescription:
          '''Pariatur Lorem id occaecat id Lorem anim fugiat enim excepteur culpa deserunt id commodo dolore. Lorem irure id minim et nulla fugiat pariatur velit ea adipisicing. Nulla culpa incididunt ullamco laborum qui est reprehenderit proident commodo pariatur sit minim consequat pariatur. Laboris ipsum aute cupidatat ea enim culpa. Est incididunt laborum fugiat commodo eiusmod consequat amet voluptate esse ut proident exercitation qui.
    Commodo minim sunt aliquip fugiat tempor non officia aute minim exercitation velit commodo id. Mollit pariatur in reprehenderit deserunt fugiat esse ea nostrud veniam adipisicing cupidatat. Dolor enim elit dolor pariatur eiusmod minim mollit incididunt cillum duis. 
    Nostrud labore ullamco tempor minim exercitation exercitation mollit tempor. Et consectetur incididunt ad incididunt reprehenderit excepteur tempor consectetur id excepteur mollit. Eu ea elit esse duis elit. Sunt fugiat incididunt incididunt sunt nulla non dolor.
    Excepteur aliquip consequat enim dolor duis id ut. Dolor dolor non culpa cillum. Esse pariatur anim fugiat sint esse veniam pariatur do. Duis occaecat nulla dolore laborum proident ex aliquip duis ad ea tempor voluptate dolore adipisicing. Eiusmod sint fugiat ex ea elit adipisicing Lorem dolore. Exercitation amet tempor id eiusmod eiusmod consequat officia fugiat cupidatat exercitation qui quis cupidatat nulla. Irure officia aute labore aliquip sit exercitation.
    Amet nisi reprehenderit in exercitation nulla. Non excepteur cillum adipisicing elit tempor irure aliquip minim ad amet ut. Nisi irure voluptate culpa in esse consequat sint. Est reprehenderit esse voluptate consectetur cillum ad. Cillum consectetur sint ipsum id eiusmod. Voluptate adipisicing Lorem et adipisicing magna sint. Quis enim quis in anim officia aliquip veniam occaecat aliquip minim laborum sit.
    Pariatur nisi nisi irure amet nulla ut dolore ad tempor irure eu deserunt sunt commodo. Exercitation ex non veniam est occaecat. Velit fugiat amet mollit consectetur ipsum sint ullamco. Anim ex cupidatat voluptate duis laboris ullamco ea. Excepteur laborum ea velit ipsum enim aliqua velit cillum ipsum minim.''',
      eventDate: '22 April 2023',
      eventTime: '19.00 - 23.00',
      eventCategory: 'Konser',
      popularity: 800,
      eventAddress: 'London, Inggris',
      ticketStock: 30,
      ticketPrice: 300000,
      mainImage:
          'https://asset.kompas.com/crops/7vD0nEzuWkaIpSbLZlJbPUwA_7s=/0x0:780x520/750x500/data/photo/2020/03/18/5e723c1fb0e60.jpg',
      imageURLs: <String>[
        'https://supermusic.id/images/posts/5668_7_karakter_penonton_festival_musik_dan_konser_di_indonesia_large.jpeg',
        'https://akcdn.detik.net.id/visual/2021/04/25/50-ribu-orang-padati-konser-terbesar-di-dunia-sejak-pandemi-melanda-2.jpeg?w=650',
        'https://assets.pikiran-rakyat.com/crop/0x0:0x0/x/photo/2020/03/12/87919148.jpg',
        'https://cl-static-v3.padangkita.com/wp-content/uploads/2020/05/limbad-768x432.webp',
      ]),
  EventModel(
      eventName: 'Lari Marathon',
      eventDescription:
          'Minim ut magna veniam id id pariatur laborum qui irure sit quis esse officia. Enim qui enim incididunt ut excepteur ex anim dolore sit nulla proident minim. Veniam voluptate non est culpa esse ex ad. Aute sit nulla cupidatat ut eu. Laborum eiusmod aute aute aliquip aute commodo Lorem anim minim ut.',
      eventDate: '11 Januari 2022',
      eventTime: '06.30 - 08.00',
      eventAddress: 'Jalan Kemerdekaan no 1',
      eventCategory: 'Umum',
      popularity: 300,
      ticketStock: 300,
      ticketPrice: 5000,
      mainImage:
          'https://freeradical.me/wp-content/uploads/2013/12/running-a-marathon.jpg',
      imageURLs: <String>[
        'https://images-na.ssl-images-amazon.com/images/I/61tjJUaaUSL.jpg',
        'https://36iusc2tb88y2g492si2bqd1-wpengine.netdna-ssl.com/wp-content/uploads/2016/05/marathon-running.jpg',
        'https://img.inews.co.id/media/822/files/inews_new/2018/08/25/marathon.jpg',
        'https://miro.medium.com/max/1024/1*ZrlYBlKXiADNJC6OsOKTMg.jpeg'
      ]),
  EventModel(
      eventName: 'Pameran Seni',
      eventDescription:
          'Incididunt ullamco ea aliquip id magna proident veniam ex. Sint consectetur elit consequat eiusmod eu mollit sunt. Ex consectetur ad enim sit cillum.',
      eventDate: '22 Oktober 2021',
      eventTime: '09.00 - 22.00',
      eventAddress: 'Jalan Pahlawan No 08',
      eventCategory: 'Pameran',
      popularity: 20,
      ticketStock: 33,
      ticketPrice: 10000,
      mainImage:
          'https://1.bp.blogspot.com/-4Yw_QHTfb8k/WI3owJcP3lI/AAAAAAAAN_g/3Y3OTR0K_X0-bnbG-ZgScyRsF6Vnv5EqgCLcB/s1600/pameran-seni-rupa-fki-02.jpg',
      imageURLs: <String>[
        'https://2.bp.blogspot.com/-GWh9iwHN_cU/XD7ORJpw6XI/AAAAAAAAAAM/-1L6A27pzIQjLRrX_5Mi8RiBs8DgHwhEACLcBGAs/s1600/pameran-seni-rupa-ponorogo-owj30g-prv.jpg',
        'https://asset.kompas.com/crops/Da9Z_WS4RQGDN_E79OHs4-_kXlQ=/0x0:1266x844/750x500/data/photo/2020/02/11/5e42bdad5ef71.jpg',
        'https://4.bp.blogspot.com/-8hGc_f4vAUc/XElurQcQ6wI/AAAAAAAAAAY/lQhCGchncMcYb3JmtP7JSYOiP0dezCCagCLcBGAs/s1600/pameran.jpg',
        'https://3.bp.blogspot.com/-5E25u5UZj0k/XAcw3tS8OlI/AAAAAAAAASU/sDMZF498TdEob3QWBdGmXGaDwMNJUVoRACLcBGAs/w1200-h630-p-k-no-nu/Pameran%2BSeni%2BRupa.jpg'
      ]),
  EventModel(
      eventName: 'Pasar Malam Kebumen',
      eventDescription:
          'Minim ut magna veniam id id pariatur laborum qui irure sit quis esse officia. Enim qui enim incididunt ut excepteur ex anim dolore sit nulla proident minim. Veniam voluptate non est culpa esse ex ad. Aute sit nulla cupidatat ut eu. Laborum eiusmod aute aute aliquip aute commodo Lorem anim minim ut.',
      eventDate: '11 Januari 2022',
      eventTime: '06.30 - 08.00',
      eventCategory: 'Festival',
      popularity: 179,
      eventAddress: 'Jalan Soekarno, Jakarta',
      ticketStock: 300,
      ticketPrice: 5000,
      mainImage:
          'https://1.bp.blogspot.com/-kJuCMbphiqU/YFDQhv3QkqI/AAAAAAAADoY/SDUh8zBXaRQZmQdOwfy26IXaUHo8STywACLcBGAsYHQ/s957/Pasar%2Bmalam%2Bsurabaya.jpg',
      imageURLs: <String>[
        'https://3.bp.blogspot.com/-J94LBLTua5k/Wl3UNHSSPBI/AAAAAAAA9bw/N4gEWKau2PgOhdbX9VdDGUdKxTaDPOISQCKgBGAs/s1600/2018-01-15.jpg',
        'http://3.bp.blogspot.com/_fxZptp-U2fQ/S9vpPp0D2zI/AAAAAAAACCI/Lc-oFUoF1VE/s1600/pasar+malam.jpg',
        'https://4.bp.blogspot.com/-qUXfLuMDEhQ/WHxEWsyHZmI/AAAAAAAAFuw/4ZUJzQeeeUE8VYMmN_eM9i5VW2-vp8sfQCLcB/s400/pasar%2Bmalam%2Bsepi%2Bpengunjung.jpg',
        'http://2.bp.blogspot.com/-C1D6k8XL3uY/U4_SkXbV6HI/AAAAAAAABcU/HOTdnTYLVPI/s1600/20140520_195425_wm.jpg'
      ]),
  EventModel(
      eventName: 'Konser Metallica',
      eventDescription:
          'Minim ut magna veniam id id pariatur laborum qui irure sit quis esse officia. Enim qui enim incididunt ut excepteur ex anim dolore sit nulla proident minim. Veniam voluptate non est culpa esse ex ad. Aute sit nulla cupidatat ut eu. Laborum eiusmod aute aute aliquip aute commodo Lorem anim minim ut.',
      eventDate: '12 Januari 2022',
      eventTime: '18.30 - 23.00',
      eventCategory: 'Konser',
      popularity: 179,
      eventAddress: 'Jalan Soekarno, Jakarta',
      ticketStock: 300,
      ticketPrice: 5000,
      mainImage:
          'https://matamatamusik.com/wp-content/uploads/2020/05/Metallica-1986-1-scaled-e1589253355872.jpg',
      imageURLs: <String>[
        'https://cdn.antaranews.com/cache/800x533/2012/12/20121203metallica.jpg',
        'http://4.bp.blogspot.com/-FgYiHByGcUQ/U_MONOwwIKI/AAAAAAAAAh8/WmO7BXGZp_Y/s1600/metallica.preview.jpg',
        'https://www.dreamers.id/img_editor/21025/images/raisa%20metallica.jpg',
        'https://matamatamusik.com/wp-content/uploads/2020/08/Metallica-drive-in-concert-1024x576.jpg'
      ]),
  EventModel(
      eventName: 'Seminar Najwa Shihab',
      eventDescription:
          'Minim ut magna veniam id id pariatur laborum qui irure sit quis esse officia. Enim qui enim incididunt ut excepteur ex anim dolore sit nulla proident minim. Veniam voluptate non est culpa esse ex ad. Aute sit nulla cupidatat ut eu. Laborum eiusmod aute aute aliquip aute commodo Lorem anim minim ut.',
      eventDate: '22 Oktober 2021',
      eventTime: '09.30 - 13.00',
      eventCategory: 'Seminar',
      popularity: 300,
      eventAddress: 'Jalan Pegangsaan Timur No. 2, Jakarta',
      ticketStock: 30,
      ticketPrice: 2000,
      mainImage:
          'https://akcdn.detik.net.id/visual/2019/04/11/8af632c0-b43a-49df-b6ca-5a92033dfe6b_169.jpeg?w=650',
      imageURLs: <String>[
        'https://awsimages.detik.net.id/community/media/visual/2019/04/11/a6690ab0-320e-40f4-9ed3-5b454f433831_43.jpeg?w=700&q=90',
        'https://i0.wp.com/www.biem.co/wp-content/uploads/2018/09/PicsArt_09-07-03.47.20.jpg',
        'https://asset.kompas.com/crops/FdB4P2Pq2EPBKi6UOK7sUx_mBJk=/8x76:1000x737/750x500/data/photo/2018/11/24/2967744661.jpeg',
        'https://beritaenam.com/wp-content/uploads/2019/01/najwa.png'
      ]),
  EventModel(
      eventName: 'Workshop Wirausahawan',
      eventDescription: '''
Mollit magna aliqua quis ut deserunt aliquip dolor nisi et eu. Consectetur occaecat ipsum anim deserunt non enim dolor anim ad Lorem elit in culpa ad. Eu veniam culpa amet voluptate commodo anim fugiat adipisicing do. Esse amet eu labore veniam velit irure aute. Sint occaecat est velit incididunt ex incididunt consequat dolore aliqua.Non adipisicing nulla do proident adipisicing. 
Qui nostrud aute cillum id reprehenderit est incididunt non labore eiusmod reprehenderit ad. Non ea ut voluptate sit consectetur irure culpa Lorem elit ullamco in cupidatat.''',
      eventDate: '16 Juli 2021',
      eventTime: '19.30 - 21.00',
      eventCategory: 'WorkShop',
      popularity: 220,
      eventAddress: 'Jalan Soekarno, Jakarta',
      ticketStock: 95,
      ticketPrice: 5000,
      mainImage:
          "http://2.bp.blogspot.com/-DLo3Ic9xy0E/UQuf2mXkErI/AAAAAAAAAJc/O444qv1rQ1Y/s1600/IMG_5069.JPG",
      imageURLs: <String>[
        "https://3.bp.blogspot.com/-KAnufetpIlI/Wh0TBWJf94I/AAAAAAAAHlk/ICvPD4ZHRvw7hZaerIXzea0EdzjyBtz_gCLcBGAs/s1600/Workshop%2BATPUSI%2BTEGAL%2B2.jpg",
        "https://1.bp.blogspot.com/-upddO-XoSpo/XomlCqeZ6qI/AAAAAAAARcM/dYEG0VmaFO04rShNpw_I3oRmnpABE4JPwCLcBGAsYHQ/s640/Workshop.png",
        "https://1.bp.blogspot.com/-1neE-scWOyQ/XarVLVN7OKI/AAAAAAAAUkg/Jp10FG8DQ1cN-eMs1H3R2CIcjFd2wm9GgCLcBGAsYHQ/s1600/IMG-20191019-WA0015.jpg",
        "https://3.bp.blogspot.com/-BYWvYbO_uvM/WmAEHnWHQNI/AAAAAAAAE-4/xKu5mpksGRcNgf1HPzs5pq8I-sPUfF_cwCLcBGAs/s1600/DSC_0301.JPG"
      ]),
];
