// Learning OS — initialize asciinema players.
// Any <div class="asciinema-player-wrapper" data-cast="path/to.cast"></div>
// becomes a terminal cast on the live site. The asciinema-player library is
// loaded from CDN via extra_javascript in mkdocs.yml. Safe no-op if the library
// is absent (e.g. a local build with no network) — the wrapper just stays empty.
(function () {
  function boot() {
    if (typeof window.AsciinemaPlayer === "undefined") return;
    document.querySelectorAll(".asciinema-player-wrapper[data-cast]").forEach(function (el) {
      if (el.dataset.loaded) return;
      el.dataset.loaded = "1";
      window.AsciinemaPlayer.create(el.dataset.cast, el, {
        cols: el.dataset.cols ? parseInt(el.dataset.cols, 10) : 90,
        rows: el.dataset.rows ? parseInt(el.dataset.rows, 10) : 24,
        poster: "npt:0:03",
        fit: "width",
        theme: "asciinema"
      });
    });
  }
  // Material uses instant navigation; re-init on each page change when available.
  if (window.document$ && typeof window.document$.subscribe === "function") {
    window.document$.subscribe(boot);
  } else {
    document.addEventListener("DOMContentLoaded", boot);
  }
})();
