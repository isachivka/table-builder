$ = require 'jquery'

module.exports = class TableBuilder

    constructor: (args) ->
        @data = args.data
        @table = args.table
        for box in @data
            td = @applyContentToTd @getFirstUnusableTd(), box
            @applyGridToTd td, box
        @table.html @table.html()

    getFirstUnusableTd: () ->
        firstUnusableTd = @table.find('td:not(.usable)').first()
        console.log firstUnusableTd.length > 0
        if firstUnusableTd.length > 0
            return firstUnusableTd
        else
            $(@trTemplate 1 + @lastRowId()).appendTo @table
            @table.find('td:not(.usable)').first()


    #addUnusableTd: () ->
    #    lastUsableTd = @table.find('td.usable').last()
    #    lastUsableTr = lastUsableTd.parent()
    #    sum = 0
    #    for usableTdInLastTr in lastUsableTr.find('td')
    #        sum += parseInt($(usableTdInLastTr).attr 'colspan')
    #    if sum is 6
    #        # append tr, append td to new tr
    #        #rowspanSum = 0
    #        #for td in $(lastUsableTr).find('td')
    #        #    colspan = parseInt($(td).attr('colspan'))
    #        #    break if colspan <= 1
    #        #    rowspanSum += colspan
    #        #coords =
    #        #    row: $(lastUsableTd).data('row') + 1
    #        #    cell: rowspanSum
    #        #return $("<tr><td data-row='#{coords.row}' data-cell='#{coords.cell}'></td></tr>")
    #        #           .insertAfter(lastUsableTr).find 'td'
    #    else
    #        # append td to last tr
    #        coords =
    #            row: $(lastUsableTd).data('row')
    #            cell: $(lastUsableTd).data('cell') + 1
    #        return $("<td data-row='#{coords.row}' data-cell='#{coords.cell}'></td>")
    #                   .insertAfter lastUsableTd

    applyContentToTd: (td, box) ->
        $(td).html box.content
        $(td).addClass 'usable'
        td

    getTdCords: (td) ->
        {
            x: $(td).data 'cell'
            y: $(td).data 'row'
        }

    applyGridToTd: (td, box) ->

        if box.width > 1 || box.height > 1
            nextTrs = $(td).parent().nextAll()
            if box.height - 1 > nextTrs.length
                for i in [1..(box.height - 1 - nextTrs.length)]
                    $(@trTemplate i + @lastRowId()).appendTo @table
            @removeCols td, @getTdCords(td), box.width - 1, box.height - 1
        else
            $(td).attr 'colspan', 1
            $(td).attr 'rowspan', 1

    lastRowId: () ->
        parseInt @table.find('tr').last().find('td').first().attr('data-row')

    trTemplate: (row) ->
        return "
            <tr>
                <td data-row='#{row}' data-cell='1'></td>
                <td data-row='#{row}' data-cell='2'></td>
                <td data-row='#{row}' data-cell='3'></td>
                <td data-row='#{row}' data-cell='4'></td>
                <td data-row='#{row}' data-cell='5'></td>
                <td data-row='#{row}' data-cell='6'></td>
            </tr>
        "

    removeCols: (td, coords, countX, countY) ->
        $(td).attr 'colspan', countX + 1
        $(td).attr 'rowspan', countY + 1
        for y in [(coords.x)..(coords.x + countX)]
            for x in [(coords.y)..(coords.y + countY)]
                continue if y is coords.x && x is coords.y
                @table.find("td[data-row='#{x}'][data-cell='#{y}']").remove()
