# Mypeople Rails

Daum에서 제공하는 API를 루비 버전으로 묶은 gem을 이용한 Rails example입니다.

## Installation

Add this line to your application's Gemfile:

    gem 'mypeople'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mypeople

## Usage

### Setup

	# /config/mypeople.yml 파일 생성
	# /config/mypoeple.yml.example 참고
	# Mypeople API
	# refer to "http://dna.daum.net/apis/mypeople"
	
	development: &base
    	host: "https://apis.daum.net"
	    key: "MYPEOPLE_API_KYE"

	test:
    	<<: *base
	production:
    	<<: *base
	
### callback controller

	/app/controller/apis_controller.rb
	
	
## Contributing

1. Fork it ( http://github.com/<my-github-username>/mypeople/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contact

	1. Taekmin Kim (tantara.tm@gmail.com)
