function init() {
  fetch("/implementations")
    .then(res=>res.ok && res.json())
    .then(obj=>initmenu(obj));
}

function initmenu(implementations) {
  let div = $("div.dropdown-menu");
  div.empty();
  implementations.forEach(i=>$("<a>").appendTo(div).addClass("dropdown-item").attr("href", "#").text(i));
  div.on("click", "a", (e)=>selectImplementation($(e.target).text()));
}

function selectImplementation(implementation) {
  fetch(`/implementations('${implementation}')/code`)
    .then(resp=>resp.text())
    .then(code=>$("div.implementation-code>pre>code").text(code))
    .then(()=>Prism.highlightElement($("div.implementation-code>pre>code")[0]))
    .then(()=>$("div.implementation-name>legend").text(implementation))
  fetch(`implementations('${implementation}')/result`)
    .then(resp=>resp.text())
    .then(result=>$("div.implementation-output>pre").text(result));
  fetch(`implementations('${implementation}')/description`)
    .then(resp=>resp.text())
    .then(description=>$("div.implementation-description").html(description));
}


init();
