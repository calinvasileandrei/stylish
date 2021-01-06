import 'package:stylish/ScraperAPI/ScraperAPI.dart';
import 'package:test/test.dart';

void main() {
  test('Return Data API', () async{
    final scraper = ScraperAPI();

    expect(await scraper.scrapeWebsite("https://www.zalando.it/fiorucci-vintage-angels-felpa-dark-grey-fi922s00e-c11.html"),
        {
          "data": {
            "brand": "Fiorucci",
            "image": "https://img01.ztat.net/article/spp-media-p1/4102e38c8cb93ef5aedb20bd43ca649c/40ce60797e9b44b7b816db17dc6ea022.jpg",
            "price": "149,99 €",
            "title": "VINTAGE ANGELS - Felpa"
          },
          "msg": "Operation Completed!",
          "status": "Ok"
        }
        );
  });
}
