/* eslint no-console:0 */

// import Rails from "rails-ujs"
// Rails.start()

import Turbolinks from "turbolinks"
Turbolinks.start()

import "expose-loader?$!jquery"
import "expose-loader?jQuery!jquery"

import "../src/javascripts/vendor/color-thief"
import "../src/javascripts/accordion"
import "../src/javascripts/alert"
import "../src/javascripts/charges"
import "../src/javascripts/dropdown"
import "../src/javascripts/markdown"
import "../src/javascripts/popup"
import "../src/javascripts/upload"
import "../src/javascripts/project"

import "../src/stylesheets/application"
