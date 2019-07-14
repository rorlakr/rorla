import { Controller } from 'stimulus'

// import 'tui-editor';
import "tui-editor/dist/tui-editor-Editor-all"
import 'tui-chart';
import 'raphael';
import 'plantuml-encoder';
import 'tui-color-picker';
import 'tui-code-snippet';

// deps for editor
require('codemirror/lib/codemirror.css'); // codemirror
require('tui-editor/dist/tui-editor.css'); // editor ui
require('tui-editor/dist/tui-editor-contents.css'); // editor content
require('highlight.js/styles/github.css'); // code block highlight
require('tui-color-picker/dist/tui-color-picker.css');
require('tui-chart/dist/tui-chart.css');

export default class extends Controller {
  static targets = [ 'content' ]

	connect(){
    console.log("tuiEditor connected!")
    $("[data-editor='tui-editor']").hide().after("<div id='editSection'></div>")
    $("#editSection").tuiEditor({
      initialEditType: 'markdown',
      initialValue: this.contentTarget.value,
      previewStyle: 'vertical',
      height: '500px',
      exts: ['scrollSync', 'colorSyntax', 'uml', 'chart', 'mark', 'table']
    })
  }

  submit(event){
    console.log('submitted....')
    this.contentTarget.textContent =$("#editSection").tuiEditor('getValue')
  }
}