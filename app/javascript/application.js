// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"

window.$ = jquery

// $(function() {
//     console.log("Hello Rails7!");
// })

// トグルボタンを遷移時閉じた状態にしたいが、現状後回し（popperJSの読み込みとbootstrapの読み込み関連が怪しい）
// import "./navbar"
