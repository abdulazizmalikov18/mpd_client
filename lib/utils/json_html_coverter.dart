import 'package:flutter/foundation.dart';

class JsonToHTML {
  final Map<String, String> tags = {
    'bold': '<b>{}</b>',
    'italic': '<i>{}</i>',
    'underline': '<u>{}</u>',
    'strikethrough': '<strike>{}</strike>',
    'code': '<code>{}</code>',
  };

  final Map<String, String> styles = {
    'bg_color': 'background: #{};',
    'font_color': 'color: #{};',
  };

  final List dataList;

  JsonToHTML(this.dataList);

  String correctHexColor(String hex) {
    if (hex.startsWith('0x')) {
      return hex.substring(2); // Remove '0x' prefix
    }
    return hex;
  }

  String getTextStyle(String text, Map<dynamic, dynamic>? attributes) {
    if (attributes == null) {
      return '<span>$text</span>';
    }

    var styleText = '';
    var tagList = <String>[];

    attributes.forEach((key, value) {
      if (key == 'bg_color' && value is String) {
        var correctedColor = correctHexColor(value);
        styleText += 'background: $correctedColor;';
      }

      if (key == 'font_color' && value is String) {
        var correctedColor = correctHexColor(value);
        styleText += 'color: $correctedColor;';
      }

      tagList.add(key);
    });

    var formattedText = text;
    for (var tag in tagList) {
      formattedText = '<$tag>$formattedText</$tag>';
    }

    return '<span style="$styleText">$formattedText</span>';
  }

  String getText(Map<String, dynamic> data) {
    var level = data['data']?['level'] ?? '';
    var align = data['data']?['align'] != null ? "text-align: ${data['data']?['align']}" : '';

    var text0 = '';
    var closeTag = '';

    if (level is int && level > 0) {
      text0 = '<h$level style="$align">';
      closeTag = '</h$level>';
    } else {
      text0 = '<div style="$align">';
      closeTag = '</div>';
    }

    var deltaList = data['data']?['delta'] ?? [];

    for (var item in deltaList) {
      if (item is Map<String, dynamic>) {
        var text = item['insert'];
        var style = item['attributes'] ?? {};
        text0 += getTextStyle(text ?? '', style);
      }
    }

    text0 += closeTag;
    return text0;
  }

  String getHtml() {
    var htmlContent = '';
    var lastNumbered = false;
    var numbered = false;

    for (var data in dataList) {
      var text = '';

      if (!numbered && lastNumbered) {
        text += '</ol>';
        lastNumbered = false;
      }

      if (data['type'] != 'numbered_list') {
        numbered = false;
      }

      switch (data['type']) {
        case 'heading':
        case 'paragraph':
          text = getText(data);
          break;
        case 'bulleted_list':
          text = getBulletedList(data);
          break;
        case 'numbered_list':
          if (!numbered) {
            text = '<ol>';
            numbered = true;
          }
          text += getNumberedList(data);
          lastNumbered = true;
          break;
        case 'table':
          text = getTable(data);
          break;
        case 'todo_list':
          text = getTodoList(data);
          break;
        default:
          text = 'Unknown type: ${data['type']}';
          break;
      }

      htmlContent += text;
    }

    if (lastNumbered) {
      htmlContent += '</ol>';
    }

    return htmlContent;
  }

  String getTable(Map<String, dynamic> data) {
    var rows = data['data']?['rowsLen'] ?? 0;
    var cols = data['data']?['colsLen'] ?? 0;
    var text = '<table border="1" style="border-collapse: collapse;">';

    if (rows > 0 && cols > 0) {
      var children = data['children'] ?? [];

      if (children.length >= rows * cols) {
        for (var i = 0; i < rows; i++) {
          text += '<tr>';
          for (var j = i; j < cols * rows; j += rows as int) {
            var child = children[j];
            text += '<td height="${child['data']?['height']}" width="${child['data']?['width']}">';

            if (child['children'] != null) {
              for (var cellChild in child['children']) {
                text += getText(cellChild);
              }
            }

            text += '</td>';
          }
          text += '</tr>';
        }
      } else {
        if (kDebugMode) {
          print('Mismatch between row/col count and children length');
        }
      }
    } else {
      if (kDebugMode) {
        print('Table rows or cols are not defined properly');
      }
    }

    text += '</table>';
    return text;
  }

  String getTodoList(Map<String, dynamic> data) {
    var text = '';

    // Handle the checkbox state
    var checked = data['data']?['checked'] ?? false;
    var checkbox = checked ? '<input type="checkbox" checked>' : '<input type="checkbox">';

    if (data['data'] != null && data['data']!['delta'] is List) {
      String textLeable = '';
      for (var item in data['data']!['delta']) {
        if (item is Map<String, dynamic>) {
          var insertText = item['insert'];
          var style = item['attributes'] ?? {};

          textLeable += getTextStyle(insertText, style);
        }
      }
      text += "$checkbox $textLeable <br><br>";
    }

    return text;
  }

  String getBulletedList(Map<String, dynamic> data) {
    var text = '<ul>';
    if (data['data'] != null && data['data']!['delta'] is List) {
      for (var item in data['data']!['delta']) {
        text += '<li>${getTextStyle(item['insert'], item['attributes'])}</li>';
      }
    }
    text += '</ul>';
    return text;
  }

  String getNumberedList(Map<String, dynamic> data) {
    var text = '<ol>';
    if (data['data'] != null && data['data']!['delta'] is List) {
      for (var item in data['data']!['delta']) {
        text += '<li>${getTextStyle(item['insert'], item['attributes'])}</li>';
      }
    }
    text += '</ol>';
    return text;
  }
}
