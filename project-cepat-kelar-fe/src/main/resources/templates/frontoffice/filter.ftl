<#-- 
  Variabel yang dibutuhkan dari Controller:
  - pageType: String ('audio' atau 'book')
  - keyword: String (untuk menjaga konteks pencarian)
  - searchAction: String (URL tujuan form, misal: /search)
  - fJudul, fPenerbit, fIsbn, fPenulis: Boolean (status centang)
-->

<style>
    /* --- Overlay Backdrop Glassmorphism --- */
    #filterModal {
        position: fixed; inset: 0;
        background-color: rgba(0, 0, 0, 0.45);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        display: none; /* Kendalikan dengan fungsi toggleFilter() */
        justify-content: center;
        align-items: center;
        z-index: 9999;
    }

    /* --- Card Filter Elegan --- */
    .filter-card {
        width: 580px; 
        background: #ffffff; 
        border-radius: 32px;
        padding: 50px; 
        position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.4);
    }

    .filter-close {
        position: absolute; top: 35px; right: 40px;
        font-size: 38px; color: #94a3b8; cursor: pointer;
        transition: color 0.2s; font-family: 'Inter', sans-serif;
    }
    .filter-close:hover { color: #3730a3; }

    .filter-title {
        font-family: 'Inter', sans-serif;
        font-size: 38px; font-weight: 700; color: #1e293b;
        text-align: center; margin-bottom: 55px;
    }

    /* --- Grid 2 Kolom Adaptif --- */
    .filter-grid {
        display: grid; 
        grid-template-columns: 1fr 1fr;
        gap: 40px 20px; 
        margin-bottom: 50px;
    }

    .filter-item {
        display: flex; align-items: center; 
        gap: 18px; cursor: pointer;
    }

    /* --- Checkbox Indigo-800 --- */
    .checkbox-ui {
        width: 42px; height: 42px;
        border: 3px solid #cbd5e1; border-radius: 12px;
        display: flex; justify-content: center; align-items: center;
        background: #f8fafc; transition: all 0.2s ease; flex-shrink: 0;
    }

    .filter-item input { display: none; }

    /* State: Terpilih (Indigo-800) */
    .filter-item input:checked + .checkbox-ui {
        background-color: #3730a3; 
        border-color: #3730a3;
        box-shadow: 0 5px 15px rgba(55, 48, 163, 0.35);
    }

    .checkbox-ui::after {
        content: "\f00c"; 
        font-family: "Font Awesome 6 Free";
        font-weight: 900; color: white; font-size: 20px; 
        display: none;
    }
    .filter-item input:checked + .checkbox-ui::after { display: block; }

    .label-text { 
        font-family: 'Inter', sans-serif;
        font-size: 24px; color: #334155; font-weight: 500; 
        line-height: 1.2;
    }

    /* --- Button Terapkan --- */
    .btn-apply {
        width: 100%; padding: 25px;
        background-color: #3730a3; color: white;
        border: none; border-radius: 20px;
        font-family: 'Inter', sans-serif;
        font-size: 28px; font-weight: 700; cursor: pointer;
        box-shadow: 0 10px 30px rgba(55, 48, 163, 0.3);
    }
</style>

<div id="filterModal">
    <div class="filter-card">
        <div class="filter-close" onclick="toggleFilter()"><i class="fas fa-times"></i></div>
        
        <h2 class="filter-title">Filter Kategori</h2>

        <form action="${searchAction!"/search"}" method="GET">
            <#-- Menjaga kata kunci pencarian tetap terbawa -->
            <input type="hidden" name="keyword" value="${keyword!""}">

            <div class="filter-grid">
                <#-- 1. Judul (Umum) -->
                <label class="filter-item">
                    <input type="checkbox" name="fJudul" value="true" ${(fJudul?? && fJudul)?string('checked', '')}>
                    <div class="checkbox-ui"></div>
                    <span class="label-text">Judul</span>
                </label>

                <#-- 2. Adaptif: Penerbit vs Label/Instansi -->
                <label class="filter-item">
                    <input type="checkbox" name="fPenerbit" value="true" ${(fPenerbit?? && fPenerbit)?string('checked', '')}>
                    <div class="checkbox-ui"></div>
                    <span class="label-text">
                        <#if pageType?? && pageType == "audio">
                            Label /<br>instansi
                        <#else>
                            Penerbit
                        </#if>
                    </span>
                </label>

                <#-- 3. ISBN (Umum) -->
                <label class="filter-item">
                    <input type="checkbox" name="fIsbn" value="true" ${(fIsbn?? && fIsbn)?string('checked', '')}>
                    <div class="checkbox-ui"></div>
                    <span class="label-text">ISBN</span>
                </label>

                <#-- 4. Adaptif: Penulis vs Pengisi Suara -->
                <label class="filter-item">
                    <input type="checkbox" name="fPenulis" value="true" ${(fPenulis?? && fPenulis)?string('checked', '')}>
                    <div class="checkbox-ui"></div>
                    <span class="label-text">
                        <#if pageType?? && pageType == "audio">
                            Pengisi<br>suara
                        <#else>
                            Penulis
                        </#if>
                    </span>
                </label>
            </div>

            <button type="submit" class="btn-apply">Terapkan Filter</button>
        </form>
    </div>
</div>

<script>
    function toggleFilter() {
        const modal = document.getElementById('filterModal');
        if (modal.style.display === 'flex') {
            modal.style.display = 'none';
        } else {
            modal.style.display = 'flex';
        }
    }
</script>