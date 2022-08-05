---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
title: | Escuelita Ultra
---

<ul class="post-list">
  {% include ultracat-biciados.html %}
  {% include 3x3-200km-mona.html %}
  {% include de-vuelta-a-las-ultra.html %}
  {% include variante-ultra.html %}
  {% include 3x3-altimetria.html %}
  {% include 3x3-200km.html %}
  {% include fase-ultra.html %}
</ul>

<script type="text/javascript">
  let tableVarianteUltra = document.getElementById('variante-ultra-table');
  let btnVarianteUltra = document.getElementById('show-variante-ultra-table');

  let tableFaseUltra = document.getElementById('fase-ultra-table');
  let btnFaseUltra = document.getElementById('show-fase-ultra-table');

  let table200km3x3 = document.getElementById('200km3x3-table');
  let btn200km3x3 = document.getElementById('show-200km3x3-table');

  function toggleUltraTable(btn, table) {
    if (btn == null || table == null)
      return;

    btn.addEventListener('click', function(event) {
      console.log("clicked", btn)
      table.style.display = '';
      btn.style.display = 'none';
      event.preventDefault();
    });
  }

  toggleUltraTable(btn200km3x3, table200km3x3);
  toggleUltraTable(btnFaseUltra, tableFaseUltra);
  toggleUltraTable(btnVarianteUltra, tableVarianteUltra);
</script>