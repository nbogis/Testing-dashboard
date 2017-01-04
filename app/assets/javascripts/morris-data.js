jQuery(function() {
  if (typeof donut_data !== 'undefined')
  {
    var donut_chart = Morris.Donut({
      element: 'morris_donut_chart',
      data: donut_data,
      resize: false,
      formatter: function (value, data) {
         return Math.floor((value/total *100).toPrecision(2)) + '%';
      },
      backgroundColor: 'none',
      labelColor: 'white',
      colors: colors
    });

    donut_chart.options.data.forEach(function(label, x) {
      var legendItem = $('<span></span>')
      .text( label['label'] + ": " + label['value']).
      prepend('<br><span>&nbsp;</span>');
      legendItem.find('span')
        .css('backgroundColor', donut_chart.options.colors[x])
        .css('width', '20px')
        .css('display', 'inline-block')
        .css('margin', '5px');
      $('#donut_legend').append(legendItem)
    });
  }

  if (typeof exec_time_bar !== 'undefined')
  {

    var bar_chart = Morris.Bar({
      element: 'exec_time_bar',
      data: time_seconds,
      xkey: 'x',
      ykeys: 'a',
      labels: labels,
      hideHover: false,
      resize: false,

      barColors: function (row, series, type) {
        if (results[row.x] == "Pass")
        	return "#66BB6A";
        else if (results[row.x] == "Fail")
          return "#EB5050";
        else if (results[row.x] == "Disabled")
          return "#FFC107";
      },

      hoverCallback: function(index, options, content,row) {
        return '<b>' + content + '</b>'+
        '<p><b> Execution time: ' + time_format[index] + '</b></p>' +
        '<p><b> Result: ' + results[index] + '</b></p>'
      },

    });

  }
// The following charts are not used in the project but can be added like the examples
  if (typeof area_data !== 'undefined')
  {
    Morris.Area({
      element: 'morris-area-chart',
      data: [
        {
          month: '2016-01',
          DBM: 150,
          SGM: 100,
          OXSC: 50
        }, {
          month: '2016-02',
          DBM: 155,
          SGM: 105,
          OXSC: 80
        }, {
          month: '2016-03',
          DBM: 140,
          SGM: 90,
          OXSC: 70
        }, {
          month: '2016-04',
          DBM: 120,
          SGM: 70,
          OXSC: 50
        }, {
          month: '2016-05',
          DBM: 160,
          SGM: 140,
          OXSC: 80
        }, {
          month: '2016-06',
          DBM: 150,
          SGM: 100,
          OXSC: 50
        }, {
          month: '2016-07',
          DBM: 170,
          SGM: 120,
          OXSC: 80
        }, {
          month: '2016-08',
          DBM: 150,
          SGM: 100,
          OXSC: 90
        }, {
          month: '2016-09',
          DBM: 140,
          SGM: 90,
          OXSC: 80
        }, {
          month: '2016-10',
          DBM: 130,
          SGM: 80,
          OXSC: 70
        }
      ],
      xkey: 'month',
      ykeys: ['DBM', 'SGM', 'OXSC'],
      labels: ['DBM', 'SGM', 'OXSC'],
      pointSize: 2,
      hideHover: 'auto',
      behaveLikeLine: true,
      resize: true
    });
  }

  if (typeof line_data !== 'undefined')
  {
    Morris.Line({
      element: 'morris-line-chart',
      data: [
        {
          month: '2016-01',
          a: 20,
          b: 30,
          c: 43
        }, {
          month: '2016-02',
          a: 10,
          b: 24,
          c: 63
        }, {
          month: '2016-03',
          a: 5,
          b: 36,
          c: 67
        }, {
          month: '2016-04',
          a: 2,
          b: 68,
          c: 41
        }, {
          month: '2016-05',
          a: 20,
          b: 75,
          c: 13
        }
      ],
      xkey: 'month',
      ykeys: ['a', 'b', 'c'],
      labels: ['DBM', 'SGM', 'OXSC'],
      hideHover: 'auto',
      resize: true
    });
  }
});
