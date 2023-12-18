![image](https://github.com/rimgosu/simkoong/assets/120752098/ddf88b71-4315-4f10-9c22-24a13ce39bf5)

# simkoong

## 개요
- 선호 이미지 기반 이성 추천 시스템을 바탕으로 한 소개팅 웹 서비스입니다.

## 시연
- 다음 프로젝트는 아래 링크를 통해 접속해 볼 수 있습니다.
- [Babe-베이브](http://15.164.48.247:8081/)
- 테스트 아이디
   - id : gaheun@gmail.com
   - pw : 1234
 
## 폴더링

```
├─java
│  └─com
│      └─example
│          │  DemoApplication.java
│          │  ServletInitializer.java
│          │
│          ├─aws
│          │      CassandraSessionManager.java
│          │      EC2MetadataService.java
│          │      EC2Migration.java
│          │      S3Config.java
│          │      TableColumnsValues.java
│          │
│          ├─controller
│          │      ChatController.java
│          │      ChatRestController.java
│          │      FileController.java
│          │      FileRestController.java
│          │      FilterController.java
│          │      InteractionController.java
│          │      MainController.java
│          │      RecommendController.java
│          │      TestController.java
│          │
│          ├─entity
│          │      AddressData.java
│          │      ChatRoomNotification.java
│          │      Chatting.java
│          │      ChattingNotification.java
│          │      Filter.java
│          │      Info.java
│          │      Interaction.java
│          │
│          ├─security
│          │      CustomUser.java
│          │      CustomUserDetailsService.java
│          │      SecurityConfig.java
│          │      WebConfig.java
│          │
│          ├─service
│          │      ChatService.java
│          │      ChatServiceImpl.java
│          │      DBService.java
│          │      DBServiceImpl.java
│          │      FileService.java
│          │      FileServiceImpl.java
│          │      FilterService.java
│          │      FliterServiceImpl.java
│          │      InfoService.java
│          │      InfoServiceImpl.java
│          │      InteractionService.java
│          │      InteractionServiceImpl.java
│          │      RecommendService.java
│          │      RecommendServiceImpl.java
│          │
│          ├─tools
│          │      FirstTimeCheckInterceptor.java
│          │      TimeCalculator.java
│          │
│          └─websocketconfig
│                  GreetingController.java
│                  TypingNotification.java
│                  WebSocketConfig.java
│
├─resources
│  │  application.properties
│  │
│  └─static
│      ├─css
│      │      bootstrap.min.css
│      │      card.css
│      │      chat.css
│      │      interaction.css
│      │      neon.css
│      │      progress.css
│      │      style.css
│      │
│      ├─img
│      │  │  0.jpg
│      │  │  about.jpg
│      │  │  age.png
│      │  │  before broken.png
│      │  │  broken-heart.png
│      │  │  call-to-action.jpg
│      │  │  carousel-1.jpg
│      │  │  carousel-2.jpg
│      │  │  couple-smelling-a-rose-sitting-on-the-floor.jpg
│      │  │  header.jpg
│      │  │  icon-apartment.png
│      │  │  icon-building.png
│      │  │  icon-condominium.png
│      │  │  icon-deal.png
│      │  │  icon-house.png
│      │  │  icon-housing.png
│      │  │  icon-luxury.png
│      │  │  icon-neighborhood.png
│      │  │  icon-search.png
│      │  │  icon-villa.png
│      │  │  logo.png
│      │  │  logogo.png
│      │  │  nick.png
│      │  │  pngwing.com.png
│      │  │  property-1.jpg
│      │  │  property-2.jpg
│      │  │  property-3.jpg
│      │  │  property-4.jpg
│      │  │  property-5.jpg
│      │  │  property-6.jpg
│      │  │  repeat.png
│      │  │  side-view-romantic-couple-with-flowers-bouquet.jpg
│      │  │  simkoong.png
│      │  │  suji.png
│      │  │  team-1.jpg
│      │  │  team-2.jpg
│      │  │  team-3.jpg
│      │  │  team-4.jpg
│      │  │  testimonial-1.jpg
│      │  │  testimonial-2.jpg
│      │  │  testimonial-3.jpg
│      │  │  testimonial-4.jpg
│      │  │  young-couple-enjoying-a-romantic-rooftop-dinner-generated-by-ai.jpg
│      │  │
│      │  ├─card
│      │  │      suji.png
│      │  │      suji2.png
│      │  │
│      │  └─x
│      │          x2.png
│      │          x3.png
│      │
│      ├─Jointemplate
│      │  ├─css
│      │  │      style.css
│      │  │      style.css.map
│      │  │      style.scss
│      │  │
│      │  ├─fonts
│      │  │  ├─chelsea_market
│      │  │  │      ChelseaMarket-Regular.ttf
│      │  │  │      OFL.txt
│      │  │  │
│      │  │  ├─material-design-iconic-font
│      │  │  │  ├─css
│      │  │  │  │      material-design-iconic-font.css
│      │  │  │  │      material-design-iconic-font.min.css
│      │  │  │  │
│      │  │  │  └─fonts
│      │  │  │          Material-Design-Iconic-Font.eot
│      │  │  │          Material-Design-Iconic-Font.svg
│      │  │  │          Material-Design-Iconic-Font.ttf
│      │  │  │          Material-Design-Iconic-Font.woff
│      │  │  │          Material-Design-Iconic-Font.woff2
│      │  │  │
│      │  │  └─muli
│      │  │          Muli-Bold.ttf
│      │  │          Muli-Regular.ttf
│      │  │          Muli-SemiBold.ttf
│      │  │
│      │  ├─images
│      │  │      error.png
│      │  │      registration-form-8.jpg
│      │  │      sign-up.png
│      │  │      valid.png
│      │  │
│      │  └─js
│      │          jquery-3.3.1.min.js
│      │          jquery.form-validator.min.js
│      │          main.js
│      │          security.js
│      │
│      ├─js
│      │      chat.js
│      │      drag-drop.js
│      │      main.js
│      │
│      ├─lib
│      │  ├─animate
│      │  │      animate.css
│      │  │      animate.min.css
│      │  │
│      │  ├─easing
│      │  │      easing.js
│      │  │      easing.min.js
│      │  │
│      │  ├─owlcarousel
│      │  │  │  LICENSE
│      │  │  │  owl.carousel.js
│      │  │  │  owl.carousel.min.js
│      │  │  │
│      │  │  └─assets
│      │  │          ajax-loader.gif
│      │  │          owl.carousel.css
│      │  │          owl.carousel.min.css
│      │  │          owl.theme.default.css
│      │  │          owl.theme.default.min.css
│      │  │          owl.theme.green.css
│      │  │          owl.theme.green.min.css
│      │  │          owl.video.play.png
│      │  │
│      │  ├─waypoints
│      │  │      links.php
│      │  │      waypoints.min.js
│      │  │
│      │  └─wow
│      │          wow.js
│      │          wow.min.js
│      │
│      ├─Logintemplate
│      │  ├─css
│      │  │      main.css
│      │  │      util.css
│      │  │
│      │  ├─fonts
│      │  │  ├─font-awesome-4.7.0
│      │  │  │  │  HELP-US-OUT.txt
│      │  │  │  │
│      │  │  │  ├─css
│      │  │  │  │      font-awesome.css
│      │  │  │  │      font-awesome.min.css
│      │  │  │  │
│      │  │  │  ├─fonts
│      │  │  │  │      fontawesome-webfont.eot
│      │  │  │  │      fontawesome-webfont.svg
│      │  │  │  │      fontawesome-webfont.ttf
│      │  │  │  │      fontawesome-webfont.woff
│      │  │  │  │      fontawesome-webfont.woff2
│      │  │  │  │      FontAwesome.otf
│      │  │  │  │
│      │  │  │  ├─less
│      │  │  │  │      animated.less
│      │  │  │  │      bordered-pulled.less
│      │  │  │  │      core.less
│      │  │  │  │      fixed-width.less
│      │  │  │  │      font-awesome.less
│      │  │  │  │      icons.less
│      │  │  │  │      larger.less
│      │  │  │  │      list.less
│      │  │  │  │      mixins.less
│      │  │  │  │      path.less
│      │  │  │  │      rotated-flipped.less
│      │  │  │  │      screen-reader.less
│      │  │  │  │      stacked.less
│      │  │  │  │      variables.less
│      │  │  │  │
│      │  │  │  └─scss
│      │  │  │          font-awesome.scss
│      │  │  │          _animated.scss
│      │  │  │          _bordered-pulled.scss
│      │  │  │          _core.scss
│      │  │  │          _fixed-width.scss
│      │  │  │          _icons.scss
│      │  │  │          _larger.scss
│      │  │  │          _list.scss
│      │  │  │          _mixins.scss
│      │  │  │          _path.scss
│      │  │  │          _rotated-flipped.scss
│      │  │  │          _screen-reader.scss
│      │  │  │          _stacked.scss
│      │  │  │          _variables.scss
│      │  │  │
│      │  │  ├─Linearicons-Free-v1.0.0
│      │  │  │  │  icon-font.min.css
│      │  │  │  │
│      │  │  │  └─WebFont
│      │  │  │          Linearicons-Free.eot
│      │  │  │          Linearicons-Free.svg
│      │  │  │          Linearicons-Free.ttf
│      │  │  │          Linearicons-Free.woff
│      │  │  │          Linearicons-Free.woff2
│      │  │  │
│      │  │  ├─montserrat
│      │  │  │      Montserrat-Black.ttf
│      │  │  │      Montserrat-BlackItalic.ttf
│      │  │  │      Montserrat-Bold.ttf
│      │  │  │      Montserrat-BoldItalic.ttf
│      │  │  │      Montserrat-ExtraBold.ttf
│      │  │  │      Montserrat-ExtraBoldItalic.ttf
│      │  │  │      Montserrat-ExtraLight.ttf
│      │  │  │      Montserrat-ExtraLightItalic.ttf
│      │  │  │      Montserrat-Italic.ttf
│      │  │  │      Montserrat-Light.ttf
│      │  │  │      Montserrat-LightItalic.ttf
│      │  │  │      Montserrat-Medium.ttf
│      │  │  │      Montserrat-MediumItalic.ttf
│      │  │  │      Montserrat-Regular.ttf
│      │  │  │      Montserrat-SemiBold.ttf
│      │  │  │      Montserrat-SemiBoldItalic.ttf
│      │  │  │      Montserrat-Thin.ttf
│      │  │  │      Montserrat-ThinItalic.ttf
│      │  │  │      OFL.txt
│      │  │  │
│      │  │  └─poppins
│      │  │          Poppins-Black.ttf
│      │  │          Poppins-BlackItalic.ttf
│      │  │          Poppins-Bold.ttf
│      │  │          Poppins-BoldItalic.ttf
│      │  │          Poppins-ExtraBold.ttf
│      │  │          Poppins-ExtraBoldItalic.ttf
│      │  │          Poppins-ExtraLight.ttf
│      │  │          Poppins-ExtraLightItalic.ttf
│      │  │          Poppins-Italic.ttf
│      │  │          Poppins-Light.ttf
│      │  │          Poppins-LightItalic.ttf
│      │  │          Poppins-Medium.ttf
│      │  │          Poppins-MediumItalic.ttf
│      │  │          Poppins-Regular.ttf
│      │  │          Poppins-SemiBold.ttf
│      │  │          Poppins-SemiBoldItalic.ttf
│      │  │          Poppins-Thin.ttf
│      │  │          Poppins-ThinItalic.ttf
│      │  │
│      │  ├─images
│      │  │  │  bg-01.jpg
│      │  │  │
│      │  │  └─icons
│      │  │          favicon.ico
│      │  │
│      │  ├─js
│      │  │      main.js
│      │  │
│      │  └─vendor
│      │      ├─animate
│      │      │      animate.css
│      │      │
│      │      ├─animsition
│      │      │  ├─css
│      │      │  │      animsition.css
│      │      │  │      animsition.min.css
│      │      │  │
│      │      │  └─js
│      │      │          animsition.js
│      │      │          animsition.min.js
│      │      │
│      │      ├─bootstrap
│      │      │  ├─css
│      │      │  │      bootstrap-grid.css
│      │      │  │      bootstrap-grid.css.map
│      │      │  │      bootstrap-grid.min.css
│      │      │  │      bootstrap-grid.min.css.map
│      │      │  │      bootstrap-reboot.css
│      │      │  │      bootstrap-reboot.css.map
│      │      │  │      bootstrap-reboot.min.css
│      │      │  │      bootstrap-reboot.min.css.map
│      │      │  │      bootstrap.css
│      │      │  │      bootstrap.css.map
│      │      │  │      bootstrap.min.css
│      │      │  │      bootstrap.min.css.map
│      │      │  │
│      │      │  └─js
│      │      │          bootstrap.js
│      │      │          bootstrap.min.js
│      │      │          popper.js
│      │      │          popper.min.js
│      │      │          tooltip.js
│      │      │
│      │      ├─countdowntime
│      │      │      countdowntime.js
│      │      │
│      │      ├─css-hamburgers
│      │      │      hamburgers.css
│      │      │      hamburgers.min.css
│      │      │
│      │      ├─daterangepicker
│      │      │      daterangepicker.css
│      │      │      daterangepicker.js
│      │      │      moment.js
│      │      │      moment.min.js
│      │      │
│      │      ├─jquery
│      │      │      jquery-3.2.1.min.js
│      │      │
│      │      ├─perfect-scrollbar
│      │      │      perfect-scrollbar.css
│      │      │      perfect-scrollbar.min.js
│      │      │
│      │      └─select2
│      │              select2.css
│      │              select2.js
│      │              select2.min.css
│      │              select2.min.js
│      │
│      ├─scss
│      │  │  bootstrap.scss
│      │  │  next.scss
│      │  │
│      │  └─bootstrap
│      │      └─scss
│      │          │  bootstrap-grid.scss
│      │          │  bootstrap-reboot.scss
│      │          │  bootstrap-utilities.scss
│      │          │  bootstrap.scss
│      │          │  _accordion.scss
│      │          │  _alert.scss
│      │          │  _badge.scss
│      │          │  _breadcrumb.scss
│      │          │  _button-group.scss
│      │          │  _buttons.scss
│      │          │  _card.scss
│      │          │  _carousel.scss
│      │          │  _close.scss
│      │          │  _containers.scss
│      │          │  _dropdown.scss
│      │          │  _forms.scss
│      │          │  _functions.scss
│      │          │  _grid.scss
│      │          │  _helpers.scss
│      │          │  _images.scss
│      │          │  _list-group.scss
│      │          │  _mixins.scss
│      │          │  _modal.scss
│      │          │  _nav.scss
│      │          │  _navbar.scss
│      │          │  _offcanvas.scss
│      │          │  _pagination.scss
│      │          │  _popover.scss
│      │          │  _progress.scss
│      │          │  _reboot.scss
│      │          │  _root.scss
│      │          │  _spinners.scss
│      │          │  _tables.scss
│      │          │  _toasts.scss
│      │          │  _tooltip.scss
│      │          │  _transitions.scss
│      │          │  _type.scss
│      │          │  _utilities.scss
│      │          │  _variables.scss
│      │          │
│      │          ├─forms
│      │          │      _floating-labels.scss
│      │          │      _form-check.scss
│      │          │      _form-control.scss
│      │          │      _form-range.scss
│      │          │      _form-select.scss
│      │          │      _form-text.scss
│      │          │      _input-group.scss
│      │          │      _labels.scss
│      │          │      _validation.scss
│      │          │
│      │          ├─helpers
│      │          │      _clearfix.scss
│      │          │      _colored-links.scss
│      │          │      _position.scss
│      │          │      _ratio.scss
│      │          │      _stretched-link.scss
│      │          │      _text-truncation.scss
│      │          │      _visually-hidden.scss
│      │          │
│      │          ├─mixins
│      │          │      _alert.scss
│      │          │      _border-radius.scss
│      │          │      _box-shadow.scss
│      │          │      _breakpoints.scss
│      │          │      _buttons.scss
│      │          │      _caret.scss
│      │          │      _clearfix.scss
│      │          │      _color-scheme.scss
│      │          │      _container.scss
│      │          │      _deprecate.scss
│      │          │      _forms.scss
│      │          │      _gradients.scss
│      │          │      _grid.scss
│      │          │      _image.scss
│      │          │      _list-group.scss
│      │          │      _lists.scss
│      │          │      _pagination.scss
│      │          │      _reset-text.scss
│      │          │      _resize.scss
│      │          │      _table-variants.scss
│      │          │      _text-truncate.scss
│      │          │      _transition.scss
│      │          │      _utilities.scss
│      │          │      _visually-hidden.scss
│      │          │
│      │          ├─utilities
│      │          │      _api.scss
│      │          │
│      │          └─vendor
│      │                  _rfs.scss
│      │
│      └─video
│              background.mp4
│              background2.mp4
│
└─webapp
    └─WEB-INF
        └─views
            │  header.jsp
            │  imgupload.jsp
            │  index.jsp
            │  join.jsp
            │  like.jsp
            │  location.jsp
            │  login.jsp
            │  otherProfile.jsp
            │  photoUpload.jsp
            │  profile.jsp
            │  sendlike.jsp
            │  update.jsp
            │
            ├─chat
            │      showChatRoom.jsp
            │
            ├─interaction
            │      interaction.jsp
            │
            └─recommend
                    matching.jsp
                    recommend.jsp
```
