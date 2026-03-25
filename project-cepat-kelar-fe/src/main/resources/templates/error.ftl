<#import "/layout/error_components.ftl" as err>

<#assign statusCode = (status!500)?c>
<#assign errorTitle = (error!"Kesalahan Server")>
<#assign messageText = (message!"Terjadi kesalahan yang tidak terduga. Silakan coba lagi.")>
<#assign requestPath = (path!"/")>
<#assign isAdminError = requestPath?starts_with("/admin")>

<#if isAdminError>
  <#import "/layout/backoffice_layout.ftl" as layout>
  <#assign activePage = "beranda">
  <#if requestPath?contains("/articles")><#assign activePage = "artikel"></#if>
  <#if requestPath?contains("/comments")><#assign activePage = "komentar"></#if>
  <#if requestPath?contains("/highlights")><#assign activePage = "sorotan"></#if>
  <#if requestPath?contains("/events")><#assign activePage = "agenda"></#if>
  <#if requestPath?contains("/collections")><#assign activePage = "koleksi"></#if>
  <#if requestPath?contains("/audio")><#assign activePage = "audio"></#if>
  <#if requestPath?contains("/voting")><#assign activePage = "voting"></#if>

  <@layout.backofficeLayout title=(statusCode + " - Terjadi Kesalahan") activePage=activePage adminName=(adminName!"Pustakawan")>
    <div class="w-full max-w-5xl mx-auto">
      <div class="bg-white rounded-3xl border border-red-200 shadow-md p-8 md:p-10">
        <div class="inline-flex items-center gap-2 bg-red-50 border border-red-200 rounded-lg px-4 py-2 mb-5">
          <span class="text-red-700 font-bold">Error ${statusCode}</span>
        </div>

        <h2 class="font-gelasio text-4xl text-slate-900 mb-3">${errorTitle}</h2>
        <p class="text-slate-600 text-lg mb-8">${messageText}</p>

        <div class="bg-slate-50 border border-slate-200 rounded-2xl p-5 space-y-2 text-sm text-slate-700">
          <div><span class="font-bold">Path:</span> ${requestPath}</div>
          <div><span class="font-bold">Waktu:</span> ${timestamp?string["dd/MM/yyyy HH:mm:ss"]!"-"}</div>
          <#if exception?? && exception?has_content>
            <div><span class="font-bold">Exception:</span> ${exception}</div>
          </#if>
          <#if message?? && message?has_content>
            <div><span class="font-bold">Detail:</span> ${message}</div>
          </#if>
        </div>

        <#if trace?? && trace?has_content>
          <div class="mt-5 bg-slate-950 text-slate-100 rounded-2xl p-4 overflow-auto max-h-72 text-xs leading-5">
            <pre class="whitespace-pre-wrap">${trace}</pre>
          </div>
        </#if>

        <div class="mt-8 flex gap-3 flex-wrap">
          <a href="javascript:history.back()" class="px-6 py-3 rounded-xl bg-indigo-700 text-white font-bold hover:bg-indigo-800 transition">Kembali</a>
          <a href="/admin/dashboard" class="px-6 py-3 rounded-xl bg-slate-200 text-slate-700 font-bold hover:bg-slate-300 transition">Ke Dashboard</a>
        </div>
      </div>
    </div>
  </@layout.backofficeLayout>
<#else>

<@err.fallbackErrorPage
  statusCode=statusCode
  errorTitle=errorTitle
  errorMessage=messageText
  path=requestPath
  timestamp=(timestamp!"-")
/>
</#if>
