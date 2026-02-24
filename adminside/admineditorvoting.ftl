<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manajemen Pemilihan | ${institutionName!"Graha Pusat Literasi"}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700&family=Gelasio:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    <style>
        /* [TRIPLE LOCK] Struktur identik dengan admineditoraudio.ftl */
        html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; }
        body { font-family: 'Lato', sans-serif; display: flex; background-color: #f8fafc; }
        .font-gelasio { font-family: 'Gelasio', serif; }
        .no-scrollbar::-webkit-scrollbar { display: none; }

        /* Custom Scrollbar Indikator */
        .scroll-indah::-webkit-scrollbar { width: 8px; display: block; }
        .scroll-indah::-webkit-scrollbar-track { background: transparent; }
        .scroll-indah::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 20px; border: 2px solid #f8fafc; }

        /* Style Input Premium - Fit, Elegant & Centered */
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
        .table-custom { border-collapse: separate; border-spacing: 0; width: 100%; }
        .table-custom th, .table-custom td { border-bottom: 1px solid #f1f5f9; border-right: 1px solid #f1f5f9; padding: 0.75rem; text-align: center; }
        .table-custom th:last-child, .table-custom td:last-child { border-right: none; }
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
      <a href="/admin/audio" class="w-full py-2 text-center hover:text-white transition">Audio</a>
      <a href="#" class="w-full py-2 text-center text-white font-bold transition">Pemilihan / Voting</a>
    </nav>
  </aside>

  <main class="flex-1 flex flex-col h-full overflow-hidden">
    
    <header class="bg-white h-28 flex-shrink-0 flex justify-end items-center pr-8 shadow-sm border-b border-stone-100 rounded-br-2xl z-40">
      <div class="flex items-center gap-8 text-indigo-900 text-2xl font-gelasio">
        <span>Halo, ${user.role!"Pustakawan"}!</span>
        <div class="flex items-center gap-3 border-l-2 pl-8 border-slate-100 cursor-pointer group" onclick="location.href='/logout'">
          <span class="group-hover:text-red-600 transition font-bold text-xl text-indigo-800">Keluar</span>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 group-hover:text-red-600 transition text-indigo-800" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </div>
      </div>
    </header>

    <div class="flex-1 overflow-y-auto p-10 bg-slate-50/50 flex flex-col gap-6 scroll-indah">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Manajemen Pemilihan</h2>
      </div>

      <form action="/admin/voting/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <input type="hidden" name="id" value="${voting.id!''}">

        <div class="space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Kegiatan Pemilihan</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="md:col-span-2">
                    <input type="text" name="name" value="${voting.name!''}" placeholder="Nama Kegiatan Pemilihan" class="input-premium" required>
                </div>
                <div>
                    <label class="label-elegant">Tanggal Mulai</label>
                    <input type="date" name="startDate" value="${voting.startDate!''}" class="input-premium" required>
                </div>
                <div>
                    <label class="label-elegant">Tanggal Selesai</label>
                    <input type="date" name="endDate" value="${voting.endDate!''}" class="input-premium" required>
                </div>
            </div>
        </div>

        <hr class="border-slate-50">

        <div class="flex flex-col lg:flex-row gap-10">
            <div class="lg:w-56 flex flex-col items-center gap-3">
                <label class="label-elegant">Unggah foto / Poster</label>
                <div class="w-52 h-52 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white transition-all group shadow-sm relative overflow-hidden">
                    <#if voting.posterUrl??>
                        <img src="${voting.posterUrl}" class="w-full h-full object-cover">
                    <#else>
                        <div class="text-center p-4">
                            <span class="block text-2xl mb-1 group-hover:scale-110 transition">🖼️</span>
                            <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Gambar</span>
                        </div>
                    </#if>
                    <input type="file" name="posterFile" class="absolute inset-0 opacity-0 cursor-pointer">
                </div>
            </div>

            <div class="flex-1 space-y-5">
                <div>
                    <label class="label-elegant">Judul</label>
                    <input type="text" name="title" value="${voting.title!''}" placeholder="Identitas, Pencipta, atau Acara" class="input-premium">
                </div>
                <div>
                    <label class="label-elegant">Keterangan singkat</label>
                    <textarea name="description" placeholder="Deskripsi Singkat / Informasi" class="input-premium h-28 resize-none py-3 text-center">${voting.description!''}</textarea>
                </div>
            </div>
        </div>

        <hr class="border-slate-50">

        <div class="space-y-5">
            <div class="flex justify-between items-center">
                <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Daftar item poin pemilihan</h3>
                <button type="button" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-6 py-2 rounded-xl shadow-md transition-all active:scale-95 text-sm font-lato">
                    + Tambah Entri Pemilihan
                </button>
            </div>
            
            <div class="border border-slate-100 rounded-2xl overflow-hidden shadow-sm">
                <table class="table-custom font-lato">
                    <thead class="bg-slate-50 text-black font-bold">
                        <tr>
                            <th class="w-24">Gambar</th>
                            <th>Item Opsi Pemilihan</th>
                            <th>Deskripsi Singkat</th>
                            <th class="w-32">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="text-slate-700">
                        <#if votingEntries?? && votingEntries?size > 0>
                          <#list votingEntries as entry>
                            <tr>
                                <td>
                                    <div class="w-12 h-12 bg-slate-200 rounded-lg mx-auto overflow-hidden">
                                        <#if entry.imageUrl??><img src="${entry.imageUrl}" class="w-full h-full object-cover"></#if>
                                    </div>
                                </td>
                                <td class="font-bold text-black">${entry.name}</td>
                                <td class="text-sm">${entry.summary}</td>
                                <td>
                                    <div class="flex justify-center gap-3 text-xl">
                                        <button type="button" title="Edit" class="hover:scale-110 transition">✏️</button>
                                        <button type="button" title="Hapus" class="hover:scale-110 transition text-red-400">🗑️</button>
                                    </div>
                                </td>
                            </tr>
                          </#list>
                        <#else>
                            <tr>
                                <td colspan="4" class="py-6 text-slate-400 italic">Belum ada entri pilihan. Klik tombol di atas untuk menambah.</td>
                            </tr>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="flex justify-center pt-6 border-t border-slate-50">
            <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-24 py-4 rounded-2xl shadow-lg transition-all active:scale-95 text-xl font-lato">
                Publikasikan Pemilihan
            </button>
        </div>

      </form> 

    </div>
  </main>
</body>
</html>