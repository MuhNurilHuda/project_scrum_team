class TourismPlace {
  String name;
  String location;
  String imageAsset;
  String openOn;
  String openAt;
  String fee;
  String description;

  TourismPlace({
    required this.name,
    required this.location,
    required this.imageAsset,
    required this.openOn,
    required this.openAt,
    required this.fee,
    required this.description,
  });
}

var tourismPlaceList = [
  TourismPlace(
      name: 'Surabaya Submarine Monument',
      location: 'Jl. Pemuda',
      imageAsset: 'assets/images/monumen kapal selam700x300.jpg',
      openOn: 'Open everyday',
      openAt: '08.00 - 16.00',
      fee: 'Rp 10.000,-',
      description:
      'The Submarine Monument, or abbreviated as Monkasel, is a submarine museum located in Embong Kaliasin, Genteng, Surabaya. Located in the city center, namely on Jalan Pemuda, right next to Plaza Surabaya, and there is an access gate to access the mall from inside the monument.'),
  TourismPlace(
    name: 'Kelenteng Sanggar Agung',
    location: 'Kenjeran',
    imageAsset:
    'assets/images/Surabaya_Submarine-Monument_shutterstock_1333444967.jpg',
    openOn: 'Open Everyday',
    openAt: '08.00 - 20.00',
    fee: 'Rp 7.000,-',
    description:
    'Sanggar Agung Temple or Hong San Tang Temple is a temple in the city of Surabaya. The address is at Jalan Sukolilo Number 100, Pantai Ria Kenjeran, Surabaya. This temple, apart from being a place of worship for adherents of the Tridharma, is also a tourist destination for tourists.',
  ),
  TourismPlace(
    name: 'House of Sampoerna',
    location: 'Krembangan Utara',
    imageAsset: 'assets/images/surabaya-submarine-monument.jpeg',
    openOn: 'Open Everyday',
    openAt: '09.00 - 7.00',
    fee: 'FREE',
    description:
    'House of Sampoerna is a tobacco museum and Sampoerna headquarters located in Surabaya. The architectural style of the main building which is influenced by the Dutch colonial style was built in 1862 and is now a historical site',
  ),
  TourismPlace(
      name: 'Gunung Bromo',
      location: 'Probolinggo',
      imageAsset:
      'assets/images/Mount_Bromo_at_sunrise,_showing_its_volcanoes_and_Mount_Semeru_(background).jpg',
      openOn: 'Open Everyday',
      openAt: '24 Hours',
      fee: 'Rp 30.000,-',
      description:
      'Mount Bromo or in the Tengger language spelled "Brama", also called the Tengger Caldera, is an active volcano in East Java, Indonesia.'),

  TourismPlace(
      name: 'Candi Borobudur',
      location: 'Magelang',
      imageAsset:
      'assets/images/Prambanan.jpeg',
      openOn: 'Open Everyday',
      openAt: '08.00 - 17.00',
      fee: 'Rp 48.000,-',
      description:
      'Borobudur Temple is a Buddhist temple located in Borobudur, Magelang, Central Java, Indonesia. This temple is located approximately 100 km southwest of Semarang, 86 km west of Surakarta, and 40 km northwest of Yogyakarta.'),
  TourismPlace(
      name: 'Candi Prambanan',
      location: 'Yogyakarta',
      imageAsset:
      'assets/images/Borobudur.jpg',
      openOn: 'Open Everyday',
      openAt: '06.30 - 17.00',
      fee: 'Rp 48.000,-',
      description:
      'Prambanan Temple is the largest Hindu temple building in Indonesia which was built in the 9th century AD.'),
  TourismPlace(
      name: 'Museum Angkut',
      location: 'Malang',
      imageAsset:
      'assets/images/Museum Angkut.jpg',
      openOn: 'Open Everyday',
      openAt: '12.00 - 20.00',
      fee: 'Rp 100.000,-',
      description:
      'Museum Angkut is a modern transportation and tourist attraction museum located in Batu City, East Java, about 20 km from Malang City. This museum is located in an area of 3.8 hectares on the slopes of Mount Panderman and has more than 300 collections of types of traditional to modern transportation.'),
  TourismPlace(
      name: 'Pantai Kuta',
      location: 'Bali',
      imageAsset:
      'assets/images/Pantai Kuta.jpg',
      openOn: 'Open Everyday',
      openAt: '06.00 - 20.00',
      fee: 'FREE',
      description:
      'Kuta Beach is a tourist spot located in the Kuta district south of Denpasar City, Bali, Indonesia. This area is a tourist destination for foreign tourists and has become a mainstay tourist attraction on the island of Bali since the early 1970s.'),
  TourismPlace(
      name: 'Pantai Pandawa',
      location: 'Bali',
      imageAsset:
      'assets/images/Pantai Pandawa.jpg',
      openOn: 'Open Everyday',
      openAt: '08.00 - 19.00',
      fee: 'FREE',
      description:
      'Pandawa Beach is one of the tourist areas in the South Kuta area, Badung Regency, Bali. This beach is located behind the hills and is often referred to as the Secret Beach. Around this beach there are two very large cliffs which on one side are carved five Pandawa and Kunti statues.'),
];
