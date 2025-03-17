// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

import "bootstrap";  // Bootstrapをインポート
import { Carousel } from 'bootstrap';

document.addEventListener('DOMContentLoaded', function () {
  var myCarousel = document.querySelector('#carouselExampleCaptions');
  var carousel = new Carousel(myCarousel, {
    interval: 5000,  // スライドの切り替え間隔 (2秒)
    ride: 'carousel' // 自動でスライドさせる
  });
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
