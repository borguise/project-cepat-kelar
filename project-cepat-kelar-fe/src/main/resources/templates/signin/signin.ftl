<#assign context = springMacroRequestContext.contextPath/>
<#assign rc=springMacroRequestContext>
<#import "/spring.ftl" as spring/>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Graha Literasi Magetan</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Lato&family=Gelasio&display=swap" rel="stylesheet">
</head>
<body class="bg-slate-200 flex justify-center items-center min-h-screen p-4">

  <div class="bg-white w-full max-w-[550px] shadow-2xl rounded-3xl flex flex-col items-center p-10 overflow-hidden">
    
    <img src="Ellipse 2.png" class="w-36 h-36 mb-6" alt="Logo Graha Literasi">

    <h1 class="text-center text-black text-2xl font-normal font-['Gelasio'] mb-6 px-4">
        ${pesanSelamatDatang!"Selamat Datang, Admin!"}
    </h1>

    <#if error??>
    <div class="w-full bg-red-100 border-l-4 border-red-500 text-red-700 p-3 mb-6 rounded text-sm font-['Lato']">
        ${error}
    </div>
    </#if>

    <form action="/login" method="POST" class="w-full space-y-6">
        
        <div class="flex flex-col gap-2">
            <label class="text-black text-xl font-normal font-['Gelasio']">Email</label>
            <input type="email" name="username" id="username" 
                   placeholder="Masukkan alamat email Anda disini" 
                   class="w-full h-12 px-4 rounded-lg bg-white border border-gray-200 shadow-md text-indigo-800 text-lg font-['Lato'] focus:ring-2 focus:ring-indigo-800 outline-none"
                   required>
        </div>

        <div class="flex flex-col gap-2">
            <label class="text-black text-xl font-normal font-['Gelasio']">Password</label>
            <input type="password" name="password" id="password" 
                   placeholder="Tuliskan Password Anda disini" 
                   class="w-full h-12 px-4 rounded-lg bg-white border border-gray-200 shadow-md text-indigo-800 text-lg font-['Lato'] focus:ring-2 focus:ring-indigo-800 outline-none"
                   required>
        </div>

        <div class="pt-4 flex justify-center">
            <button type="submit" class="w-40 h-12 bg-indigo-800 text-white rounded-lg shadow-lg hover:bg-indigo-900 transition-all text-xl font-['Lato']">
                Masuk
            </button>
        </div>

    </form>
  </div>

</body>
</html>
