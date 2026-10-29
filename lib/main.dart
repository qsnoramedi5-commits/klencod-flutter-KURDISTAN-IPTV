import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const KurdistanIPTVApp());
}

class KurdistanIPTVApp extends StatefulWidget {
  const KurdistanIPTVApp({Key? key}) : super(key: key);

  @override
  State<KurdistanIPTVApp> createState() => _KurdistanIPTVAppState();
}

class _KurdistanIPTVAppState extends State<KurdistanIPTVApp> {
  String currentLang = 'badini';

  final Map<String, Map<String, String>> localizedStrings = {
    'badini': {
      'app_title': 'KURDISTAN IPTV',
      'home': 'سەرەکی',
      'settings': 'ڕێکخستن',
      'about': 'دەربارەی مە',
      'search': 'لێگەڕیان ل کەنالان...',
      'all': 'هەمی',
      'version': 'ڤێرژن: 2.4.0',
      'visit_website': 'سەرەدانا ماڵپەڕی بکە',
      'contact_us': 'پەیوەندی ب مە بکە',
      'about_desc': 'ئەپلیکەیشنا KURDISTAN IPTV باشترین و خێراترین ئەپە بۆ تەماشاکرنا راستەوخۆیا کەنالێن کوردی و جیهانی ب کوالێتیەکا زۆر بەرز و ب بێ بچران.',
      'language': 'زمان',
    },
    'sorani': {
      'app_title': 'KURDISTAN IPTV',
      'home': 'سەرەکی',
      'settings': 'ڕێکخستن',
      'about': 'دەربارەی ئێمە',
      'search': 'گەڕان بۆ کەناڵەکان...',
      'all': 'هەموو',
      'version': 'ڤێرژن: 2.4.0',
      'visit_website': 'سەردانی ماڵپەڕ بکە',
      'contact_us': 'پەیوەندی بمان بکە',
      'about_desc': 'ئەپڵیکەیشنی KURDISTAN IPTV باشترین و خێراترین ئەپە بۆ سەیرکردنی ڕاستەوخۆی کەناڵە کوردی و جیهانییەکان بە کوالیتیەکی زۆر بەرز و بێ پچڕان.',
      'language': 'زمان',
    },
    'en': {
      'app_title': 'KURDISTAN IPTV',
      'home': 'Home',
      'settings': 'Settings',
      'about': 'About Us',
      'search': 'Search channels...',
      'all': 'All',
      'version': 'Version: 2.4.0',
      'visit_website': 'Visit Website',
      'contact_us': 'Contact Us',
      'about_desc': 'KURDISTAN IPTV is the ultimate app for streaming live Kurdish and international TV channels with top quality and zero buffering.',
      'language': 'Language',
    },
    'ar': {
      'app_title': 'KURDISTAN IPTV',
      'home': 'الرئيسية',
      'settings': 'الإعدادات',
      'about': 'عن التطبيق',
      'search': 'البحث عن القنوات...',
      'all': 'الكل',
      'version': 'الإصدار: 2.4.0',
      'visit_website': 'زيارة الموقع',
      'contact_us': 'تواصل معنا',
      'about_desc': 'تطبيق KURDISTAN IPTV هو الأفضل والأسرع لمشاهدة البث المباشر للقنوات الكردية والعالمية بجودة عالية وبدون تقطيع.',
      'language': 'اللغة',
    },
  };

  void changeLanguage(String langCode) {
    setState(() {
      currentLang = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KURDISTAN IPTV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF030A1C),
        primaryColor: const Color(0xFF1E88E5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF061539),
          elevation: 4,
        ),
      ),
      home: MainScreen(
        currentLang: currentLang,
        strings: localizedStrings[currentLang]!,
        onChangeLanguage: changeLanguage,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String currentLang;
  final Map<String, String> strings;
  final Function(String) onChangeLanguage;

  const MainScreen({
    Key? key,
    required this.currentLang,
    required this.strings,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(strings: widget.strings),
      SettingsPage(
        strings: widget.strings,
        currentLang: widget.currentLang,
        onChangeLanguage: widget.onChangeLanguage,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://cdn.phototourl.com/member/2026-10-29-87d55c9b-16cb-4d86-989f-d149f705de90.png',
              height: 36,
              errorBuilder: (_, __, ___) => const Icon(Icons.tv, color: Colors.blue),
            ),
            const SizedBox(width: 10),
            Text(
              widget.strings['app_title']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.lightBlueAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(strings: widget.strings),
                ),
              );
            },
          )
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF061539),
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: widget.strings['home'],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: widget.strings['settings'],
          ),
        ],
      ),
    );
  }
}

// Model for Channel
class Channel {
  final String name;
  final String url;
  final String category;

  Channel({required this.name, required this.url, required this.category});
}

class HomePage extends StatefulWidget {
  final Map<String, String> strings;

  const HomePage({Key? key, required this.strings}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<Channel> channels = [
    Channel(name: "KU | RUDAW TV", url: "https://live.rudaw.net/hls/rudaw-tv/master.m3u8", category: "News"),
    Channel(name: "KU | AVA MEDIA TV", url: "https://ava002.xyz/upload/images/1080.m3u8", category: "General"),
    Channel(name: "KU | KURDISTAN 24 TV", url: "https://hlspackager.akamaized.net/live/DB/K24/HLS/K24.m3u8", category: "News"),
    Channel(name: "KU | SPEDA TV HD", url: "https://www.speda2.site/upload/images/spedahd.m3u8", category: "General"),
    Channel(name: "KU | GALI KURDISTAN TV", url: "https://live.host247.net/gk/gksat/chunklist_w1879482920.m3u8", category: "General"),
    Channel(name: "KU | KURDSAT NEWS TV", url: "https://hlspackager.akamaized.net/live/DB/KURDSAT_NEWS/HLS/KURDSAT_NEWS.m3u8", category: "News"),
    Channel(name: "KU | NUÇÊ TV", url: "https://hlspackager.akamaized.net/live/DB/NU_TV/HLS/NU_TV.m3u8", category: "News"),
    Channel(name: "KU | NRT TV HD", url: "https://hlspackager.akamaized.net/live/DB/NRT_HD/HLS/NRT_HD-avc1_2500000=10002,mp4a_128000=20000.m3u8", category: "News"),
    Channel(name: "KU | CHANNEL 8", url: "https://live.channel8.com/Channel8-Kurdish/index.m3u8", category: "News"),
    Channel(name: "KU | MMN NEWS TV", url: "http://mmn.mypsx.net:1935/live/mmnhdnews/playlist.m3u8", category: "News"),
    Channel(name: "KU | AFARIN TV HD", url: "https://65f16f0fdfc51.streamlock.net/afarinTV/livestream/chunklist_w187911945.m3u8", category: "General"),
    Channel(name: "KU | AFARIN TV HD (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/4591.ts", category: "General"),
    Channel(name: "KU | KURDISTAN TV HD", url: "https://5a3ed7a72ed4b.streamlock.net/live/SMIL:myStream.smil/playlist.m3u8", category: "General"),
    Channel(name: "KU | SHAR TV HD", url: "http://avrstream.com:1935/live/SHARTV/playlist.m3u8", category: "General"),
    Channel(name: "KU | AVAR TV HD", url: "https://avr.host247.net/live/AvarTv/playlist.m3u8", category: "General"),
    Channel(name: "KU | KURDSAT TV HD", url: "https://hlspackager.akamaized.net/live/DB/KURDSAT_HD/HLS/KURDSAT_HD.m3u8", category: "General"),
    Channel(name: "KU | WELAT TV HD", url: "https://stream.badinan.xyz/welat/tv/playlist.m3u8", category: "General"),
    Channel(name: "KU | BASK TV HD", url: "http://baskhd.ddns.net:40/live/baskhd/playlist.m3u8", category: "General"),
    Channel(name: "KU | EURO KURD TV", url: "http://baskhd.ddns.net:40/live/Eurokurd/index.m3u8", category: "General"),
    Channel(name: "KU | GK+ TV HD", url: "https://live.host247.net/gk/gkplus/playlist.m3u8", category: "General"),
    Channel(name: "KU | PESHANG TV HD", url: "https://stream.forcaroo.com/stream/hls/desktop.m3u8", category: "General"),
    Channel(name: "KU | RED TV HD", url: "http://avrstream.com:1935/live/REDTV/playlist.m3u8", category: "General"),
    Channel(name: "KU | KURD7 TV HD", url: "http://avrstream.com:1935/live/Kurd7HD/playlist.m3u8", category: "General"),
    Channel(name: "KU | HOMZHYAR TV HD", url: "http://avrstream.com:1935/live/HormzyarHD/playlist.m3u8", category: "General"),
    Channel(name: "KU | GEWHER TV HD", url: "https://cdn.karwan.tv/gewher-tv/index.m3u8", category: "General"),
    Channel(name: "KU | WAAR TV HD", url: "https://live.kwikmotion.com/waarmedialive/waarmedia.smil/playlist.m3u8", category: "General"),
    Channel(name: "KU | AVA FAMILY TV", url: "https://familyhls.avatv.live/hls/stream.m3u8", category: "General"),
    Channel(name: "KU | KHAK TV HD", url: "http://bblserver.ddns.net:1935/stream/khakhd/tracks-v1a1/mono.m3u8", category: "General"),
    Channel(name: "KU | PAYAM TV HD", url: "https://media2.streambrothers.com:1936/8218/8218/playlist.m3u8", category: "General"),
    Channel(name: "KU | 4KURD TV HD", url: "https://4kuhls.persiana.live/hls/stream.m3u8", category: "General"),
    Channel(name: "KU | CAN TV HD", url: "https://livetv.canbroadcast.com:7443/canlican/tv.m3u8", category: "General"),
    Channel(name: "KU | CIRA TV HD", url: "https://hlspackager.akamaized.net/live/DB/CIRA_TV/HLS/CIRA_TV.m3u8", category: "General"),
    Channel(name: "KU | JIN TV HD", url: "https://live.jintv.org/medialive/jintv.m3u8", category: "General"),
    Channel(name: "KU | KURD CHANNEL TV", url: "https://kurdchhls.wns.live/hls/stream.m3u8", category: "General"),
    Channel(name: "KU | MMN DOCUMENTARY TV", url: "http://mmn.mypsx.net:1935/live/mmnhddocumentary/playlist.m3u8", category: "Documentary"),
    Channel(name: "KU | SHNA TV HD", url: "http://shnatv.ddns.net:1935/live/shnatv/playlist.m3u8", category: "General"),
    Channel(name: "KU | MIX TV HD", url: "http://avrstream.com:1935/live/Mix-kurdy/playlist.m3u8", category: "General"),
    Channel(name: "KU | NAQSHI MEDIA TV", url: "http://naqshi-media.com:1935/live/NaqshiMedia/playlist.m3u8", category: "General"),
    Channel(name: "KU | REHBER TV HD", url: "https://cdn4.yayin.com.tr/rehbertv/tracks-v1a1/mono.m3u8", category: "Islamic"),
    Channel(name: "KU | SORAN ENTERTAIMENT TV", url: "http://avrstream.com:1935/live/SoranEntertainment/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | BAHA TV HD", url: "http://baskhd.ddns.net:40/live/baskhd/yusfstore.m3u8", category: "General"),
    Channel(name: "KU | SADA TV HD", url: "http://sada-hd.ddns.net:40/live/sadatv/index.m3u8", category: "General"),
    Channel(name: "KU | BARIN MOVIES TV", url: "https://cdn.karwan.tv/barin-movies/index.m3u8", category: "Movies"),
    Channel(name: "KU | BARIN FAMILY TV", url: "http://baskhd.ddns.net:40/live/BarinfamilyHD/mono.m3u8", category: "General"),
    Channel(name: "KU | NEW FAMILY TV", url: "https://cdn.karwan.tv/bnar-family/index.m3u8", category: "General"),
    Channel(name: "KU | NEW MOVIES TV", url: "https://cdn.karwan.tv/bnar-movies/index.m3u8", category: "Movies"),
    Channel(name: "KU | NEW ACTION TV", url: "https://cdn.karwan.tv/bnar-action/index.m3u8", category: "Movies"),
    Channel(name: "KU | ZHIN FILM TV", url: "https://183.bozztv.com/giatv/giatv-zhintv/zhintv/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | MMN ART TV", url: "http://mmn.mypsx.net:1935/live/mmnhdmovies/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | MMN ACTION TV", url: "http://mmn.mypsx.net:1935/live/mmnhdaction/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | SPEDA DRAMA TV", url: "https://www.speda2.site/upload/images/spedadrama.m3u8", category: "Movies"),
    Channel(name: "KU | ZAROK TV KURMANJI", url: "https://zindikurmanci.zaroktv.com.tr/hls/stream.m3u8", category: "Kids"),
    Channel(name: "KU | ZAROK TV HD", url: "https://zindisorani.zaroktv.com.tr/hls/0/stream.m3u8", category: "Kids"),
    Channel(name: "KU | GEWHER KIDS TV", url: "https://cdn.karwan.tv/gewher-kids/index.m3u8", category: "Kids"),
    Channel(name: "KU | KIDCO TV HD", url: "http://avrstream.com:1935/live/kidcohd/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | ZOOMOO TV HD", url: "https://zoomoo-samsungau.amagi.tv/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | TOM AND JERRY TV", url: "https://live20.bozztv.com/giatvplayout7/giatv-208314/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | RYAN AND FREINDS TV", url: "https://ryanandfriends-samsungau.amagi.tv/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | ABC KIDS TV", url: "https://c.mjh.nz/abc-kids.m3u8", category: "Kids"),
    Channel(name: "KU | BABY SHARK TV", url: "https://c0c65b821b3542c3a4dca92702f59944.mediatailor.us-east-1.amazonaws.com/v1/master/04fd913bb278d8775298c26fdca9d9841f37601f/RakutenTV-eu_BabySharkTV/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | MARAYA KIDS TV", url: "https://live.kwikmotion.com/smckidslive/tjkids1.smil/smckidspublish/tjkids1_source/chunks.m3u8", category: "Kids"),
    Channel(name: "KU | BANGAWAZ TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129958.m3u8", category: "Islamic"),
    Channel(name: "KU | AMOZHGARI TV HD", url: "https://app-live.org/live/3268334b/index.m3u8", category: "Islamic"),
    Channel(name: "KU | ACADEMY AMOZHGARI TV", url: "https://app-live.org/live/a267c1b3/index.m3u8", category: "Islamic"),
    Channel(name: "KU | EMAN TV HD", url: "https://avr.host247.net/live/emantv/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | FARMOODA TV HD", url: "https://avr.host247.net/live/FarmodaTV/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | WALLA QURAN TV", url: "http://cdn.karwan.tv/WALAQURAN/index.m3u8", category: "Islamic"),
    Channel(name: "KU | IMK TV HD", url: "http://imkhd.ddns.net:1935/live/imkhd/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | IMK QURAN TV", url: "http://avrstream.com:1935/live/IMKQURANHD/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | SPI QURAN TV", url: "https://183.bozztv.com/giatv/giatv-spi_quran_hd/spi_quran_hd/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | MMN QURAN TV", url: "http://mmn.mypsx.net:1935/live/mmnhdquran/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | ASHTI QURAN TV", url: "http://avrstream.com:1935/live/AshtiTV/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | MIHRAB TV HD", url: "http://baskhd.ddns.net:40/live/MihrabTV/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | MIHRAB FM HD", url: "http://bblserver.ddns.net:1935/live/mihrabfm/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | SOZ QURAN TV", url: "http://live20.bozztv.com/giatv/giatv-sozquran/sozquran/chunks.m3u8", category: "Islamic"),
    Channel(name: "KU | SOZ TV HD", url: "https://live20.bozztv.com/giatv/giatv-sozetv/sozetv/chunks.m3u8", category: "Islamic"),
    Channel(name: "KU | RAWSHAN TV HD", url: "http://rawshan.ddns.net:1935/live/rawshantv/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | SAUDI QURAN TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/3880.ts", category: "Islamic"),
    Channel(name: "KU | SAUDI QURAN TV (Server 2)", url: "https://win.holol.com/live/quran/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | SAUDI SUNNAH TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/3591.ts", category: "Islamic"),
    Channel(name: "KU | SAUDI SUNNAH TV (Server 2)", url: "https://win.holol.com/live/sunnah/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | ISLAMIC MEDIA LIVE 1", url: "https://media2.streambrothers.com:1936/8122/8122/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | KSA QURAN RADIO", url: "https://live.kwikmotion.com/sbrksaquranradiolive/srpksaquranradio/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | GEWHER SPORT TV", url: "https://cdn.karwan.tv/gewher-sport/index.m3u8", category: "Sports"),
    Channel(name: "KU | MMN SPORT TV", url: "http://mmn.mypsx.net:1935/live/mmnhdsport/playlist.m3u8", category: "Sports"),
    Channel(name: "AR | QATAR TV HD", url: "https://qatartv.akamaized.net/hls/live/20000609/qtv1/master.m3u8", category: "General"),
    Channel(name: "AR | QATAR TV 2", url: "https://qatartv.akamaized.net/hls/live/20000611/qtv2/master.m3u8", category: "General"),
    Channel(name: "AR | WATAN TV HD", url: "https://rp.tactivemedia.com/watantv_source/live/playlist.m3u8", category: "General"),
    Channel(name: "AR | ZAGROS 24 TV HD", url: "https://hlspackager.akamaized.net/live/DB/ZAGROS_24/HLS/ZAGROS_24.m3u8", category: "News"),
    Channel(name: "AR | ALGHAD TV HD", url: "https://eazyvwqssi.erbvr.com/alghadtv/alghadtv.m3u8", category: "News"),
    Channel(name: "AR | AL ARABIA NEWS", url: "https://live.kwikmotion.com/alaraby1live/alaraby_abr/playlist.m3u8", category: "News"),
    Channel(name: "KU | PARWARDAYI SLEMANI TV", url: "https://183.bozztv.com/giatv/giatv-parwardasuli/parwardasuli/playlist.m3u8", category: "General"),
    Channel(name: "KU | PARWARDAYI DUHOK TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212763.ts", category: "General"),
    Channel(name: "AR | BBC EARTH TV", url: "https://amg00793-amg00793c6-xumo-us-2669.playouts.now.amagi.tv/BBCStudios-BBCEarthA-hls/playlist.m3u8", category: "Documentary"),
    Channel(name: "AR | SPACETOON TV HD", url: "https://live-uae-next.spacetoongo.com/ST_MENA_NEXT/hls/r9p2hjipmw2kl.m3u8", category: "Kids"),
    Channel(name: "KU | TRT 1 TV", url: "https://tv-trt1.medya.trt.com.tr/master.m3u8", category: "General"),
    Channel(name: "KU | TRT NEWS/HABER TV", url: "https://tv-trthaber.medya.trt.com.tr/master.m3u8", category: "News"),
    Channel(name: "KU | TRT MUSIC TV", url: "https://tv-trtmuzik.medya.trt.com.tr/master.m3u8", category: "General"),
    Channel(name: "KU | TRT KURDI TV", url: "https://tv-trtkurdi.medya.trt.com.tr/master.m3u8", category: "General"),
    Channel(name: "KU | TRT ARABIC TV", url: "https://tv-trtarabi.medya.trt.com.tr/master.m3u8", category: "General"),
    Channel(name: "KU | SKY NEWS TV", url: "https://stream.skynewsarabia.com/hls/sna.m3u8", category: "News"),
    Channel(name: "KU | ACTION HOLLYWOOD TV", url: "https://cdn-apse1-prod.tsv2.amagi.tv/linear/amg01076-lightningintern-actionhollywood-samsungnz/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | CNN TV HD", url: "https://turnerlive.warnermediacdn.com/hls/live/586495/cnngo/cnn_slate/VIDEO_0_3564000.m3u8", category: "News"),
    Channel(name: "KU | NETFLIX ACTION HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487989.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX ACTION 2 HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487986.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX ACTION 3 HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487985.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX ANIME HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/488002.m3u8", category: "Kids"),
    Channel(name: "KU | NETFLIX COMEDY HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487974.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX DRAMA 1 HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487994.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX DRAMA 2 HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487993.m3u8", category: "Movies"),
    Channel(name: "KU | NETFLIX KIDS HD", url: "http://vip2.sharkhost.xyz:80/live/9143315182/7352465335/487967.m3u8", category: "Kids"),
    Channel(name: "KU | IRAQIA KURDISH", url: "https://imn-live.esite-lab.com/hls/iraqia-kurdish.m3u8", category: "General"),
    Channel(name: "KU | IRAQIA NEWS", url: "https://imn-live.esite-lab.com/hls/iraqia-news.m3u8", category: "News"),
    Channel(name: "KU | IRAQIA SPORT", url: "https://imn-live.esite-lab.com/hls/iraqia-sports-1.m3u8", category: "Sports"),
    Channel(name: "KU | PESHMARGA TV HD", url: "https://live20.bozztv.com/giatv/giatv-Shawkat/peshmerge/playlist.m3u8", category: "General"),
    Channel(name: "KU | DIGLAH TV HD", url: "https://ghaasiflu.online/Dijlah/index.m3u8", category: "General"),
    Channel(name: "KU | BEFRIN TV HD", url: "https://cdn.karwan.tv/befrin-tv/index.m3u8", category: "General"),
    Channel(name: "KU | ATV HD", url: "https://b.livev.xyz/aytv/tracks-v1a1/mono.m3u8", category: "General"),
    Channel(name: "KU | SHOW TV HD", url: "https://b.livev.xyz/kanald/tracks-v1a1/mono.m3u8", category: "General"),
    Channel(name: "KU | SUNNAH DENG", url: "https://live20.bozztv.com/akamaissh101/ssh101/oneplussunnattv/chunks.m3u8", category: "Islamic"),
    Channel(name: "KU | BINER TV HD", url: "https://live20.bozztv.com/giatv/giatv-Shawkat/Biner_HD/chunks.m3u8", category: "General"),
    Channel(name: "KU | ALHADATH TV", url: "https://live.alarabiya.net/alarabiapublish/alhadath.smil/alarabiapublish/alhadath_1080p/chunks.m3u8", category: "News"),
    Channel(name: "KU | MRBEAN TV HD", url: "https://amg00627-amg00627c31-rakuten-fr-3991.playouts.now.amagi.tv/playlist/amg00627-banijayfast-mrbeanfrcc-rakutenfr/playlist.m3u8", category: "Movies"),
    Channel(name: "KU | IRAQ 24 TV HD", url: "https://ghaasiflu.online/Iraq24/tracks-v1a1/mono.m3u8", category: "News"),
    Channel(name: "KU | ZNAR KIDS TV", url: "https://live20.bozztv.com/giatv/giatv-znarkids/znarkids/chunks.m3u8", category: "Kids"),
    Channel(name: "KU | UFC TV HD", url: "https://linear-893.frequency.stream/dist/xumo/893/hls/master/playlist.m3u8", category: "Sports"),
    Channel(name: "KU | DAZN 1 TV HD", url: "http://50.7.120.34:8080/DAZN1/tracks-v1a1/mono.m3u8", category: "Sports"),
    Channel(name: "KU | DAZN 2 TV HD", url: "http://23.237.104.106:8080/DAZN_2/tracks-v1a1/mono.m3u8", category: "Sports"),
    Channel(name: "KU | DAZN 3 TV HD", url: "http://23.237.104.106:8080/DAZN_3/tracks-v1a1/mono.m3u8", category: "Sports"),
    Channel(name: "KU | DAZN 4 TV HD", url: "http://23.237.104.106:8080/DAZN_4/tracks-v1a1/mono.m3u8", category: "Sports"),
    Channel(name: "KU | NATURE TIME TV", url: "https://amg00090-blueantmedia-naturetime-samsungse-axgcn.amagi.tv/playlist/amg00090-blueantmedia-naturetime-samsungse/playlist.m3u8", category: "Documentary"),
    Channel(name: "KU | KURDMAX TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212807.ts", category: "General"),
    Channel(name: "KU | KURDMAX MUSIC TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212806.ts", category: "General"),
    Channel(name: "KU | KURDMAX PEPULE TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212805.ts", category: "Kids"),
    Channel(name: "KU | JAZZIRA TV HD", url: "https://live-hls-web-aja2-gcp.thehlive.com/AJA2/01.m3u8", category: "News"),
    Channel(name: "KU | JAZZIRA TV HD 2", url: "https://live-hls-apps-ajm2-fa.getaj.net/AJM2/01.m3u8", category: "News"),
    Channel(name: "KU | STV OREMAR TV", url: "https://lbgo.bozztv.com/ssh101/live/stv-oremar/playlist.m3u8", category: "General"),
    Channel(name: "KU | Bahrain Sports 1", url: "https://5c7b683162943.streamlock.net/live/sportsone/playlist.m3u8", category: "Sports"),
    Channel(name: "KU | Bahrain Sports 2", url: "https://5c7b683162943.streamlock.net/live/bahrainsportstwo/playlist.m3u8", category: "Sports"),
    Channel(name: "KU | Bahrain TV", url: "https://5c7b683162943.streamlock.net/live/bahraintvmain/playlist.m3u8", category: "General"),
    Channel(name: "KU | Bahrain International", url: "https://5c7b683162943.streamlock.net/live/bahraininternational/playlist.m3u8", category: "General"),
    Channel(name: "KU | Bahrain Quran", url: "https://5c7b683162943.streamlock.net/live/bahrainquran/playlist.m3u8", category: "Islamic"),
    Channel(name: "KU | RANIA TV HD", url: "https://ranyatv.avrstream.com/RanyaTV/tracks-v1a1/playlist.m3u8", category: "General"),
    Channel(name: "KU | RANYA CITY TV", url: "https://avr.host247.net/Ranya/RanyaCity/tracks-v1a1/mono.m3u8", category: "General"),
    Channel(name: "KU | QELLAT TV HD", url: "http://213.32.255.86:1935/live/Qellat_tv/playlist.m3u8", category: "General"),
    Channel(name: "KU | ARABIA TV HD", url: "https://live.alarabiya.net/alarabiapublish/alarabiya.smil/playlist.m3u8", category: "News"),
    Channel(name: "KU | KELGA TV HD", url: "https://lbgo.bozztv.com/ssh101/live/Kelga/playlist.m3u8", category: "General"),
    Channel(name: "KU | RASHHED TV HD", url: "https://media1.livaat.com/static/AL-RASHEED-HD/playlist.m3u8", category: "General"),
    Channel(name: "KU | ZAGROS TV HD", url: "https://hlspackager.akamaized.net/live/DB/ZAGROS_TV/HLS/ZAGROS_TV.m3u8", category: "General"),
    Channel(name: "KU | 3ABN KIDS TV", url: "https://3abn.bozztv.com/3abn2/Kids_live/smil:Kids_live.smil/playlist.m3u8", category: "Kids"),
    Channel(name: "KU | TAHA KIDS TV HD", url: "https://stream.starmenajo.com/hls/app/live/ts:fhd.m3u8", category: "Kids"),
    Channel(name: "KU | LD NUJEN TV", url: "http://stap2025.me:8080/live/nsbp46qijx/ukbyu5668f/312666.m3u8", category: "General"),
    Channel(name: "KU | LD NUJEN TV (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212795.ts", category: "General"),
    Channel(name: "KU | DERIN TV HD", url: "http://baskhd.ddns.net:40/live/Derin/playlist.m3u8", category: "General"),
    Channel(name: "KU | BBC NEWS TV", url: "https://vs-hls-push-ww-live.akamaized.net/x=4/i=urn:bbc:pips:service:bbc_news_channel_hd/t=3840/v=pv14/b=5070016/main.m3u8", category: "News"),
    Channel(name: "KU | LD SPORT 1 TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/280502.m3u8", category: "Sports"),
    Channel(name: "KU | LD SPORT 1 TV (Server 2)", url: "http://27966691.tvway.pro/live/Q52F93A8/54122821/526629.ts", category: "Sports"),
    Channel(name: "KU | NRT SPORT TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/280437.m3u8", category: "Sports"),
    Channel(name: "KU | NRT SPORT TV (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212765.ts", category: "Sports"),
    Channel(name: "KU | NRT SPORT TV (Server 3)", url: "http://s21tv.co:2082/live/893963693051/bHksg68fWnri8/807709.ts", category: "Sports"),
    Channel(name: "KU | ASO SPORT TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/456256.m3u8", category: "Sports"),
    Channel(name: "KU | ASO SPORT TV (Server 2)", url: "http://mytop2020.life:2095/live/893963693051/bHksg68fWnri8/807597.ts", category: "Sports"),
    Channel(name: "KU | DUHOK SPORT TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/689913.m3u8", category: "Sports"),
    Channel(name: "KU | DUHOK SPORT TV (Server 2)", url: "http://mytop2020.life:2095/live/893963693051/bHksg68fWnri8/807625.ts", category: "Sports"),
    Channel(name: "KU | DASINYA SPORT TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/689911.m3u8", category: "Sports"),
    Channel(name: "KU | ZAXO SPORT TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/280431.m3u8", category: "Sports"),
    Channel(name: "KU | ALWAN SPORT 1 TV", url: "http://m3u.drm-26.com/live/Mkdtv1_061261/4STJysUc/1641618.m3u8", category: "Sports"),
    Channel(name: "KU | ALWAN SPORT 2 TV", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/1641619.m3u8", category: "Sports"),
    Channel(name: "KU | BEIN SPORT 1 TV", url: "http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/110.m3u8", category: "Sports"),
    Channel(name: "KU | BEIN SPORT 2 TV", url: "http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/111.m3u8", category: "Sports"),
    Channel(name: "KU | BEIN SPORT 3 TV", url: "http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/112.m3u8", category: "Sports"),
    Channel(name: "KU | BEIN SPORT 4 TV", url: "http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/113.m3u8", category: "Sports"),
    Channel(name: "KU | BEIN SPORT 5 TV", url: "http://xtreamutv.org:80/live/pvVrD1gEuh/Wty1TYowId/114.m3u8", category: "Sports"),
    Channel(name: "KU | DUHOK TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129835.m3u8", category: "General"),
    Channel(name: "KU | DUHOK TV HD (Server 2)", url: "http://familyku.me:2095/291142475920/16275591516967bdb3a0578/19919", category: "General"),
    Channel(name: "KU | DUHOK TV HD (Server 3)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212837.ts", category: "General"),
    Channel(name: "KU | KIRKUK TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/29289.m3u8", category: "General"),
    Channel(name: "KU | ASMAN TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280455.m3u8", category: "General"),
    Channel(name: "KU | NRT 4 TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129975.m3u8", category: "News"),
    Channel(name: "KU | MBC 1 TV HD", url: "https://shd-gcp-live.edgenextcdn.net/live/bitmovin-mbc-1/15cf99af5de54063fdabfefe66adc075/index.m3u8", category: "Movies"),
    Channel(name: "KU | MBC 2 TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/168140.ts", category: "Movies"),
    Channel(name: "KU | MBC 3 TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/168088.ts", category: "Kids"),
    Channel(name: "KU | MBC IRAQ TV", url: "https://shd-gcp-live.edgenextcdn.net/live/bitmovin-mbc-iraq/e38c44b1b43474e1c39cb5b90203691e/index.m3u8", category: "General"),
    Channel(name: "KU | MBC IRAQ TV (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/168134.ts", category: "General"),
    Channel(name: "KU | MBC MASR TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/2003.ts", category: "General"),
    Channel(name: "KU | ZAXO TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280432.m3u8", category: "General"),
    Channel(name: "KU | ZAXO TV HD (Server 2)", url: "http://iptvtree.net:8080/Javamicro/0481fbb702/300290", category: "General"),
    Channel(name: "KU | ZAXO TV HD (Server 3)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212730.ts", category: "General"),
    Channel(name: "KU | XABIR TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/456279.m3u8", category: "General"),
    Channel(name: "KU | TASAWF TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/280441.m3u8", category: "Islamic"),
    Channel(name: "KU | QALLAM TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312553.m3u8", category: "General"),
    Channel(name: "KU | QALLAM TV HD (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212762.ts", category: "General"),
    Channel(name: "KU | QALLAM AYINI TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312672.m3u8", category: "Islamic"),
    Channel(name: "KU | QALLAM AYINI TV HD (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212761.ts", category: "Islamic"),
    Channel(name: "KU | QALLAM KIDS TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212759.ts", category: "Kids"),
    Channel(name: "KU | NRT 2 TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129977.m3u8", category: "News"),
    Channel(name: "KU | NRT 2 TV HD (Server 2)", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212769.ts", category: "News"),
    Channel(name: "KU | KANI TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/150570.m3u8", category: "General"),
    Channel(name: "KU | DASINYA TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/312579.m3u8", category: "General"),
    Channel(name: "KU | MINARA TV HD", url: "http://m3u.drm-26.com:80/live/Mkdtv1_061261/4STJysUc/129888.m3u8", category: "General"),
    Channel(name: "KU | ZED TV HD", url: "http://mytop2020.life:2095/live/893963693051/bHksg68fWnri8/807753.ts", category: "General"),
    Channel(name: "KU | ZED PLUS TV", url: "http://mytop2020.life:2095/live/893963693051/bHksg68fWnri8/807752.ts", category: "General"),
    Channel(name: "KU | U2 TV", url: "http://line.iptv-4k.cc/live/Tuankeane9/C430F4/1443631.ts", category: "General"),
    Channel(name: "KU | NEWLINE 1 TV HD", url: "http://mytop2020.life:2095/live/893963693051/bHksg68fWnri8/807691.ts", category: "General"),
    Channel(name: "KU | NEWLINE 2 TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212782.ts", category: "General"),
    Channel(name: "KU | NEWLINE MOVIES TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212779.ts", category: "Movies"),
    Channel(name: "KU | NEWLINE SPORT TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212777.ts", category: "Sports"),
    Channel(name: "KU | DASINYA KIDS TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212845.ts", category: "Kids"),
    Channel(name: "KU | DELAL SPORT TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212843.ts", category: "Sports"),
    Channel(name: "KU | NRT 3 TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212768.ts", category: "News"),
    Channel(name: "KU | SIMA TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212743.ts", category: "General"),
    Channel(name: "KU | SLEMANI TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212740.ts", category: "General"),
    Channel(name: "KU | U TV HEWLER", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212734.ts", category: "General"),
    Channel(name: "KU | SEE SPORT 1", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212729.ts", category: "Sports"),
    Channel(name: "KU | ALKASS 1 TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/89778.ts", category: "Sports"),
    Channel(name: "KU | ALKASS 2 TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/89779.ts", category: "Sports"),
    Channel(name: "KU | ALKASS 4 TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/210262.ts", category: "Sports"),
    Channel(name: "KU | Majd KIDS TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/4641.ts", category: "Kids"),
    Channel(name: "KU | BMC TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212847.ts", category: "General"),
    Channel(name: "KU | DASINYA SPORT TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212844.ts", category: "Sports"),
    Channel(name: "KU | DERWAZA MUSIC TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212841.ts", category: "General"),
    Channel(name: "KU | DERWAZA TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212840.ts", category: "General"),
    Channel(name: "KU | DIMEN TV HD", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/212839.ts", category: "General"),
    Channel(name: "KU | SAUDI NEWS TV", url: "http://25.mhpro1.xyz/live/zee00457/98063c219806/3590.ts", category: "News"),
    Channel(name: "KU | DEVER TV HD", url: "http://tomixe.in/live/SME3UM814GQ7761/425HJZJOaW/771668.ts", category: "General"),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['All', 'News', 'Sports', 'Kids', 'Islamic', 'Movies', 'Documentary', 'General'];

    List<Channel> filteredChannels = channels.where((ch) {
      bool matchesCat = selectedCategory == 'All' || ch.category == selectedCategory;
      bool matchesSearch = ch.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            onChanged: (value) => setState(() => searchQuery = value),
            decoration: InputDecoration(
              hintText: widget.strings['search'],
              prefixIcon: const Icon(Icons.search, color: Colors.lightBlueAccent),
              filled: true,
              fillColor: const Color(0xFF091E42),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Categories List
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              String cat = categories[index];
              bool isSelected = selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(cat == 'All' ? widget.strings['all']! : cat),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  backgroundColor: const Color(0xFF091E42),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Grid View of Channels
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredChannels.length,
            itemBuilder: (context, index) {
              Channel ch = filteredChannels[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(channel: ch),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A224F),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_fill, size: 40, color: Colors.lightBlueAccent),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          ch.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Video Player Screen
class PlayerScreen extends StatefulWidget {
  final Channel channel;

  const PlayerScreen({Key? key, required this.channel}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.channel.url));
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      allowFullScreen: true,
      fullScreenByDefault: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'شاشە ناهێتە ڤەکرن یان پەخش ناهێتە وەرگرتن.\n$errorMessage',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channel.name),
      ),
      body: Center(
        child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(controller: _chewieController!)
            : const CircularProgressIndicator(),
      ),
    );
  }
}

// Settings Screen
class SettingsPage extends StatelessWidget {
  final Map<String, String> strings;
  final String currentLang;
  final Function(String) onChangeLanguage;

  const SettingsPage({
    Key? key,
    required this.strings,
    required this.currentLang,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: Colors.blueAccent),
            title: Text(strings['language']!),
            trailing: DropdownButton<String>(
              value: currentLang,
              dropdownColor: const Color(0xFF091E42),
              items: const [
                DropdownMenuItem(value: 'badini', child: Text('کوردیا بادینی')),
                DropdownMenuItem(value: 'sorani', child: Text('کوردیی سۆرانی')),
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
              ],
              onChanged: (String? val) {
                if (val != null) onChangeLanguage(val);
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.web, color: Colors.blueAccent),
            title: Text(strings['visit_website']!),
            subtitle: const Text('http://kurdistaniptv.netlify.app'),
            onTap: () async {
              final Uri url = Uri.parse('http://kurdistaniptv.netlify.app');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),

          // Kurdistan Flag Colors
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 40, height: 10, color: Colors.red),
              Container(width: 40, height: 10, color: Colors.white),
              Container(width: 40, height: 10, color: Colors.yellow),
              Container(width: 40, height: 10, color: Colors.green),
            ],
          ),
          const SizedBox(height: 10),
          Text(strings['version']!, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// About Screen
class AboutPage extends StatelessWidget {
  final Map<String, String> strings;

  const AboutPage({Key? key, required this.strings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings['about']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.network(
              'https://cdn.phototourl.com/member/2026-10-29-87d55c9b-16cb-4d86-989f-d149f705de90.png',
              height: 100,
              errorBuilder: (_, __, ___) => const Icon(Icons.tv, size: 80, color: Colors.blue),
            ),
            const SizedBox(height: 15),
            Text(
              strings['app_title']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              strings['about_desc']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const Spacer(),
            Text(
              '${strings['contact_us']!}:',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 5),
            const SelectableText(
              'qsnoramedi5@gmail.com',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}