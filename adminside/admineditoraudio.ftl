<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Editor Audio | ${institutionName!"Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Struktur identik dengan admineditorkoleksi.ftl */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; background-color: #f8fafc; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        /* Custom Scrollbar Indikator */
        .scroll-indah::-webkit-scrollbar { width: 8px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: transparent; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 20px; border: 2px solid #f8fafc; }

        /* Style Input Premium - Compact & Centered */
        .input-premium {
            width: 100%;
            background-color: white;
            padding: 0.6rem 1rem;
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
            outline: none;
            color: #3730a3;
            font-size: 1rem;
            text-align: center;
        }
        .input-premium:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
        }
        .label-elegant {
            display: block;
            font-size: 1rem;
            font-weight: 700;
            font-family: 'Gelasio', serif;
            margin-bottom: 0.3rem;
            color: #1e293b;
            text-align: center;
        }
    </style>
</head>
<body>

  <aside class="w-60 bg-[#1e293b] text-stone-300 flex flex-col h-full flex-shrink-0 shadow-2xl z-50 rounded-br-2xl">
    <div class="h-28 flex items-center justify-center border-b border-slate-700/50 flex-shrink-0">
      <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center overflow-hidden border-2 border-slate-600 shadow-lg">
        <img src="/images/logo.png" alt="Logo" class="w-full h-full object-cover">
      </div>
    </div>
    <nav class="flex-1 px-4 py-8 space-y-5 font-gelasio text-lg flex flex-col overflow-y-auto no-scrollbar text-stone-400">
      <a href="/admin/beranda" class="w-full py-2 text-center hover:text-white transition">Beranda</a>
      <a href="/admin/artikel" class="w-full py-2 text-center hover:text-white transition leading-tight">Artikel & Berita</a>
      <a href="/admin/komentar" class="w-full py-2 text-center hover:text-white transition">Komentar</a>
      <a href="/admin/sorotan" class="w-full py-2 text-center hover:text-white transition">Sorotan</a>
      <a href="/admin/agenda" class="w-full py-2 text-center hover:text-white transition leading-tight">Agenda Kegiatan</a>
      <a href="/admin/koleksi" class="w-full py-2 text-center hover:text-white transition">Koleksi Buku</a>
      <a href="/admin/audio" class="w-full py-2 text-center text-white font-bold transition underline underline-offset-8">Audio</a>
      <a href="/admin/pemilihan" class="w-full py-2 text-center hover:text-white transition text-base leading-tight">Pemilihan / Voting</a>
    </nav>
  </aside>

  <main class="flex-1 flex flex-col h-full overflow-hidden">
    
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center pr-8 shadow-sm border-b border-stone-100 rounded-br-2xl z-40">
      <div class="flex items-center gap-8 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${user.role!"Pustakawan"}!</span>
        <div class="flex items-center gap-3 border-l-2 pl-8 border-slate-100 cursor-pointer group" onclick="location.href='/logout'">
          <span class="group-hover:text-red-600 transition font-bold text-xl">Keluar</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 group-hover:text-red-600 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </div>
      </div>
    </header>

    <div class="flex-1 overflow-y-auto p-10 bg-slate-50/50 flex flex-col gap-6 scroll-indah">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Editor Rekaman Audio</h2>
      </div>

      <form action="/admin/audio/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <input type="hidden" name="id" value="${audio.id!''}">

        <div class="flex flex-col lg:flex-row gap-10">
          <div class="flex-1 space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">I. Data Utama</h3>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="label-elegant">Nomor Panggil</label>
                    <input type="text" name="callNumber" value="${audio.callNumber!''}" placeholder="Nomor ddc" class="input-premium">
                </div>
                <div>
                    <label class="label-elegant">Subjek</label>
                    <input type="text" name="subject" value="${audio.subject!''}" placeholder="Materi audio" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">Judul Rekaman</label>
                    <input type="text" name="title" value="${audio.title!''}" placeholder="Judul audio" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">Pernyataan Tanggung Jawab</label>
                    <input type="text" name="responsibility" value="${audio.responsibility!''}" placeholder="Nama Pengisi suara" class="input-premium">
                </div>
                <div class="md:col-span-2">
                    <label class="label-elegant">General Material Designation</label>
                    <input type="text" name="gmd" value="${audio.gmd!''}" placeholder="[rekaman suara]" class="input-premium">
                </div>
            </div>
          </div>

          <div class="lg:w-56 flex flex-col items-center justify-center pt-8">
            <div class="w-52 h-64 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white hover:border-indigo-400 transition-all group overflow-hidden relative">
              <#if audio.coverUrl??>
                <img src="${audio.coverUrl}" class="w-full h-full object-cover">
              <#else>
                <div class="text-center p-4">
                  <span class="block text-2xl mb-1 group-hover:scale-110 transition">🖼️</span>
                  <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Cover</span>
                </div>
              </#if>
              <input type="file" name="coverFile" class="absolute inset-0 opacity-0 cursor-pointer">
            </div>
          </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">II. Data Penerbit</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="label-elegant">Label / Lembaga</label>
              <input type="text" name="publisher" value="${audio.publisher!''}" placeholder="Nama Penerbit" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Kota Asal</label>
              <input type="text" name="originCity" value="${audio.originCity!''}" placeholder="Daerah Terbit" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Tahun Terbit</label>
              <input type="text" name="publishYear" value="${audio.publishYear!''}" placeholder="Waktu Terbit" class="input-premium">
            </div>
          </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
          <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">III. Data Fisik</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="label-elegant">Jumlah dan Jenis Media</label>
              <input type="text" name="mediaType" value="${audio.mediaType!''}" placeholder="1 keping cd" class="input-premium">
            </div>
            <div>
              <label class="label-elegant">Detail dan Format Suara</label>
              <input type="text" name="audioFormat" value="${audio.audioFormat!''}" placeholder="mp3, mp4," class="input-premium">
            </div>
          </div>
        </div>

        <div class="flex justify-center pt-6 border-t border-slate-50">
          <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-24 py-4 rounded-2xl shadow-lg transition-all active:scale-95 text-xl font-lato">
            Simpan Rekaman Audio
          </button>
        </div>

      </form> 

    </div>
  </main>
</body>
</html>