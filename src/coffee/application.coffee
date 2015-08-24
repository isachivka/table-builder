$ = require 'jquery'
TableBuilder = require './TableBuilder'

boxes = [
    {
        width: 2
        height: 2
        content: '<div class="content">1</div>'
    }
    {
        width: 1
        height: 3
        content: '<div class="content">2</div>'
    }
    {
        width: 3
        height: 3
        content: '<div class="content">3</div>'
    }
    {
        width: 1
        height: 1
        content: '<div class="content">4</div>'
    }
    {
        width: 1
        height: 1
        content: '<div class="content">5</div>'
    }
    {
        width: 6
        height: 1
        content: '<div class="content">6</div>'
    }
    {
        width: 3
        height: 1
        content: '<div class="content">7</div>'
    }
    {
        width: 1
        height: 1
        content: '<div class="content">8</div>'
    }
    {
        width: 1
        height: 1
        content: '<div class="content">9</div>'
    }
    {
        width: 1
        height: 1
        content: '<div class="content">10</div>'
    }
]

tableBuilder = new TableBuilder
    data: boxes
    table: $('table#bla')
