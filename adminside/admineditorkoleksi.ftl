<#-- admin/editor-koleksi.ftl -->
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <#-- Judul dinamis: Jika data 'buku' ada, tampilkan Edit, jika tidak tampilkan Tambah -->
    <title>Admin - <#if buku??>Edit<#else>Tambah</#if> Buku | Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Menjamin konsistensi dengan halaman Katalog */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
        .scroll-indah::-webkit-scrollbar { width: 10px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: #f1f5f9; border-radius: 10px; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border: 2px solid #f1f5f9; border-radius: 10px; }
        
        .input-bersih { 
            width: 100%; background: white; border-radius: 0.75rem; padding: 0.75rem 1.25rem; 
            border: 1px solid #e2e8f0; outline: none; transition: all 0.2s; color: #1e293b;
        }
        .input-bersih:focus { border-color: #6366f1; ring: 3px; ring-color: rgba(99, 102, 241, 0.1); }
        .label-form { display: block; font-family: 'Gelasio', serif; font-weight: 700; font-size: 1.1rem; color: #0f172a; margin-bottom: 0.5rem; }
    </style>
</head>
<body class="bg-[#f8fafc]">

  <#-- 1. SIDEBAR (KONSISTEN) -->
  <aside class="w-64 bg-[#1e293b] text-stone-300 flex flex-col h-full flex-shrink-0 shadow-2xl z-50 rounded-br-2xl">
    <div class="h-28 flex items-center justify-center border-b border-slate-700/50 flex-shrink-0">
      <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-slate-600 shadow-lg">
        <img src="/images/logo-magetan.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>
      <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio flex flex-col overflow-y-auto no-scrollbar">
      <a href="/admin/beranda" class="w-full py-2 text-center hover:text-white transition font-normal text-stone-400">Beranda</a>
      <a href="/admin/artikel" class="w-full py-2 text-center hover:text-white transition leading-tight text-stone-400">Artikel & Berita</a>
      <a href="/admin/komentar" class="w-full py-2 text-center hover:text-white transition text-stone-400">Komentar</a>
      <a href="/admin/sorotan" class="w-full py-2 text-center text-white font-bold transition">Sorotan</a>
      <a href="/admin/agenda" class="w-full py-2 text-center hover:text-white transition leading-tight text-stone-400">Agenda Kegiatan</a>
      <a href="/admin/koleksi" class="w-full py-2 text-center hover:text-white transition text-stone-400">Koleksi Buku</a>
      <a href="/admin/audio" class="w-full py-2 text-center hover:text-white transition text-stone-400">Audio</a>
      <a href="/admin/voting" class="w-full py-2 text-center hover:text-white transition text-base leading-tight text-stone-400">Pemilihan / Voting</a>
    </nav>
  </aside>

  <main class="flex-1 flex flex-col h-full overflow-hidden">
    <#-- 2. HEADER (KONSISTEN) -->
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center pr-8 shadow-sm border-b border-stone-100 rounded-br-2xl z-40">
      <div class="flex items-center gap-8 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${user.nama!"Pustakawan"}!</span>
        <div class="font-bold text-xl text-indigo-800 border-l-2 pl-8 border-slate-100 cursor-pointer">Keluar</div>
      </div>
    </header>

    <#-- 3. AREA FORM (SCROLLABLE) -->
    <div class="flex-1 overflow-y-auto p-12 bg-slate-50/50 flex flex-col gap-10 scroll-indah">      
      <div class="max-w-4xl w-full mx-auto px-4">
        <h2 class="text-4xl font-bold font-gelasio text-black italic">
            <#if buku??>Edit Koleksi Buku<#else>Tambah Buku Baru</#if>
        </h2>
      </div>

      <#-- Action dinamis berdasarkan keberadaan objek buku -->
      <form action="<#if buku??>/admin/koleksi/update/${buku.id}<#else>/admin/koleksi/simpan</#if>" method="POST" enctype="multipart/form-data" class="max-w-4xl w-full mx-auto bg-white rounded-3xl shadow-xl border border-slate-100 p-12 mb-12 flex flex-col gap-12">
        
        <#-- DATA UTAMA -->
        <div class="flex gap-12 items-start">
            <div class="flex-1 flex flex-col gap-8">
                <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b pb-2 border-slate-50">Data Utama</h3>
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="label-form">Nomor Panggil</label>
                        <input type="text" name="nomorPanggil" value="${(buku.nomorPanggil)!''}" placeholder="Nomor DDC" class="input-bersih">
                    </div>
                    <div>
                        <label class="label-form">Subjek / Kategori</label>
                        <input type="text" name="subjek" value="${(buku.subjek)!''}" placeholder="Fiksi, Sejarah, dsb." class="input-bersih">
                    </div>
                </div>
                <div>
                    <label class="label-form">Judul Buku</label>
                    <input type="text" name="judul" value="${(buku.judul)!''}" placeholder="Masukkan judul lengkap" class="input-bersih font-bold">
                </div>
                <div>
                    <label class="label-form">Tajuk Pengarang</label>
                    <input type="text" name="pengarang" value="${(buku.pengarang)!''}" placeholder="Nama belakang, Nama depan" class="input-bersih">
                </div>
            </div>

            <#-- SAMPUL -->
            <div class="w-64 flex flex-col gap-4">
                <label class="label-form text-center">Sampul Buku</label>
                <div class="w-full aspect-[3/4] bg-slate-50 rounded-2xl border-2 border-dashed border-slate-300 flex flex-col items-center justify-center gap-4 group hover:border-indigo-400 transition cursor-pointer relative overflow-hidden">
                    <#if (buku.sampul)??>
                        <img src="${buku.sampul}" class="absolute inset-0 w-full h-full object-cover">
                    <#else>
                        <span class="text-4xl text-slate-300">📷</span>
                    </#if>
                    <input type="file" name="fileSampul" class="absolute inset-0 opacity-0 cursor-pointer z-10">
                    <span class="text-indigo-800 text-sm font-bold text-center px-6 bg-white/80 py-1 rounded-full z-20">Unggah Gambar</span>
                </div>
            </div>
        </div>

        <#-- DATA PENERBIT -->
        <div class="flex flex-col gap-8">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b pb-2 border-slate-50">Data Penerbit</h3>
            <div class="grid grid-cols-3 gap-6">
                <div>
                    <label class="label-form">Penerbit</label>
                    <input type="text" name="penerbit" value="${(buku.penerbit)!''}" class="input-bersih">
                </div>
                <div>
                    <label class="label-form">Kota Terbit</label>
                    <input type="text" name="kota" value="${(buku.kota)!''}" class="input-bersih">
                </div>
                <div>
                    <label class="label-form">Tahun Terbit</label>
                    <input type="text" name="tahun" value="${(buku.tahun)!''}" placeholder="YYYY" class="input-bersih">
                </div>
            </div>
        </div>

        <#-- DATA FISIK (POSISI DIREVISI) -->
        <div class="flex flex-col gap-8">
            <h3 class="text-2xl font-bold font-gelasio text-indigo-900 border-b pb-2 border-slate-50">Data Fisik & Stok</h3>
            
            <#-- Deskripsi Fisik berada di atas ISBN dan Stok -->
            <div>
                <label class="label-form">Deskripsi Fisik</label>
                <textarea name="deskripsiFisik" rows="3" placeholder="Contoh: xii, 350 hlm; ilus; 20 cm." class="input-bersih scroll-indah resize-none">${(buku.deskripsiFisik)!''}</textarea>
            </div>

            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="label-form">Nomor ISBN</label>
                    <input type="text" name="isbn" value="${(buku.isbn)!''}" placeholder="978-..." class="input-bersih">
                </div>
                <div>
                    <label class="label-form">Jumlah Stok</label>
                    <input type="number" name="stok" value="${(buku.stok)!'0'}" class="input-bersih">
                </div>
            </div>
        </div>

        <div class="flex justify-end gap-6 pt-6">
            <button type="submit" class="px-10 h-12 bg-[#bef264] text-indigo-900 rounded-xl shadow-lg font-bold hover:bg-lime-400 transition-all active:scale-95">
                <span>Simpan Buku</span>
            </button>
        </div>
      </form>
    </div>
  </main>
</body>
</html>