<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>
<@layout.backofficeLayout title="Admin - Editor Voting" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Manajemen Pemilihan</h2>
      </div>

      <form action="/admin/voting/save" method="POST" enctype="multipart/form-data" class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
                <input type="hidden" name="id" value="${(voting.id)!''}">

        <div class="space-y-5">
            <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Kegiatan Pemilihan</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="md:col-span-2">
                    <input type="text" name="name" value="${(voting.name)!''}" placeholder="Nama Kegiatan Pemilihan" class="input-premium" required>
                </div>
                <div>
                    <label class="label-elegant">Tanggal Mulai</label>
                    <input type="date" name="startDate" value="${(voting.startDate)!''}" class="input-premium" required>
                </div>
                <div>
                    <label class="label-elegant">Tanggal Selesai</label>
                    <input type="date" name="endDate" value="${(voting.endDate)!''}" class="input-premium" required>
                </div>
            </div>
        </div>

        <hr class="border-slate-50">

        <div class="flex flex-col lg:flex-row gap-10">
            <div class="lg:w-56 flex flex-col items-center gap-3">
                <label class="label-elegant">Unggah foto / Poster</label>
                <div class="w-52 h-52 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white transition-all group shadow-sm relative overflow-hidden">
                    <#if voting?? && voting.posterUrl?? && voting.posterUrl?has_content>
                        <img src="${(voting.posterUrl)!''}" class="w-full h-full object-cover" onerror="this.classList.add('hidden')">
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
                    <input type="text" name="title" value="${(voting.title)!''}" placeholder="Identitas, Pencipta, atau Acara" class="input-premium">
                </div>
                <div>
                    <label class="label-elegant">Keterangan singkat</label>
                    <textarea name="description" placeholder="Deskripsi Singkat / Informasi" class="input-premium h-28 resize-none py-3">${(voting.description)!''}</textarea>
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
                                        <#if entry.imageUrl?? && entry.imageUrl?has_content><img src="${entry.imageUrl}" class="w-full h-full object-cover" onerror="this.classList.add('hidden')"></#if>
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

</@layout.backofficeLayout>