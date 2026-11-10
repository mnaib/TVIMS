using System;
using System.IO;
using System.IO.Compression;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
 
using DbAccess;
using Ionic.Zip;
using System.Text;
using System.Runtime.Serialization;  
using System.Runtime.Serialization.Formatters.Binary; 
using System.Configuration;
using System.Web.Services.Protocols; 
using System.Web.Services.Description;
 

namespace WebDB
{

    public class bytestr
    {
        public bytestr() { }

        public string name;
        public byte[] bayt;
    }
    
   
public class AuthSoapHd : SoapHeader
{ public string mobtoken;
    public string strUserName;
    public string strPassword;
}
 //   <soap:Header>
 //  <AuthenticationHeader>
 //    <UserName>string</UserName>
 //    <Password>string</Password>
 //  </AuthenticationHeader>
 //</soap:Header>

    /// <summary>
    /// Summary description for Service1
    /// </summary>
    //  [WebService(Namespace = "www.XMLWebServiceSoapHeaderAuth.net")]
   [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]

    public class GetDB : System.Web.Services.WebService
    {
        //        public HttpContext Context
        //{
        //    get
        //    {
        //        return HttpContext.Current;
        //    }
        //}
        //public HttpRequest Request
        //{
        //    get
        //    {


        //        return HttpContext.Current.Request;
        //    }
        //}


      //  string cnStr = "Data Source=172.16.0.18; Initial Catalog=mufettis; User ID=gisuser; Password=G1s_2014_sqs";
        string cnStr = ConfigurationManager.ConnectionStrings["Db18Connection"].ConnectionString;
         public AuthSoapHd spAuthenticationHeader;
         string  token = ConfigurationManager.AppSettings["mobtoken"];
       
        //  string strUsrName = ConfigurationManager.AppSettings["UserName"];
        //string strPassword = ConfigurationManager.AppSettings["Password"];
          [WebMethod, SoapHeader("spAuthenticationHeader")]
    public void CheckToken() 
    {

 
            //          IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
          string  mobtoken = HttpContext.Current.Request.Headers["mobtoken"];
            
 
//IncomingWebRequestContext request = WebOperationContext.Current.IncomingRequest;
//WebHeaderCollection headers = request.Headers;
// System.ServiceModel.Web.WebOperationContext ctx = System.ServiceModel.Web.WebOperationContext.Current;
//String request_header_value1 = ctx.IncomingRequest.Headers["Incoming_Req_Header_Key1"].ToString();
      //      string dd = WebOperationContext.Current.IncomingRequest.Headers["mobtoken"];
    
//           var httpRequestProperty = new HttpRequestMessageProperty();
//httpRequestProperty.Headers["xd"] = "xd";
//OperationContext.Current.OutgoingMessageProperties[HttpRequestMessageProperty.Name] = httpRequestProperty; 
            
            
            if ((mobtoken!= null)&&(mobtoken ==token))
      {
                int aa = 7;
        }
        else
        {
                throw new AccessViolationException();
                //VersionNotFoundException();// Exception("Not");
            //  throw new ArgumentNullException();
        }
    }
 



        [WebMethod]
        public bytestr dbdown(  string baza, string listab)
        {

            CheckToken();
            
     //       string listab = "Mekteb,*";
            bytestr strbaytitem = new bytestr();
            strbaytitem.name = "yalan"; ;
            strbaytitem.bayt = null;
   
   string sqlConnString = @"Data Source=172.16.0.18;Initial Catalog=" + baza + ";User ID=gisuser;Password=G1s_2014_sqs";
             string tempfolder= Path.GetTempPath();
            
             string fileName = "no"; 
            DateTime dd = DateTime.Now;
 // string sqlitePath = Path.GetTempPath() + "DBS" + Path.GetRandomFileName().Split('.')[0];
            string sqlitePath =  tempfolder+ "DBS" + Path.GetRandomFileName().Split('.')[0];

            sqlitePath += dd.Minute.ToString() + dd.Second.ToString() + ".db";
            fileName = SqlServerToSQLite.ConvertSqlServerToSQLiteDatabase(sqlConnString, sqlitePath, listab);

            GC.Collect();
            FileStream fs = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
// FileStream fs = new FileStream(fileName, FileMode.Open);

            MemoryStream ms = new MemoryStream();
            int buffLength = 1024;
            byte[] buff = new byte[buffLength];
            



 
            // Read from the file stream 2kb at a time
            int contentLen = fs.Read(buff, 0, buffLength);

            // Till Stream content ends
            while (contentLen != 0)
            {
                // Write Content from the file stream to the FTP Upload Stream
                ms.Write(buff, 0, contentLen);
                contentLen =fs.Read(buff, 0, buffLength);
            }

            // Close the file stream and the Request Stream

     fs.Close();
           fs.Dispose();
     File.Delete(fileName);     
            
             strbaytitem.name = fileName;
                strbaytitem.bayt = ms.ToArray();
                ms.Close();
      ms.Dispose();
 
             
            return  strbaytitem;
        }

         




        [WebMethod]
        public bytestr zdbdown( string baza, string listab)
        {
             CheckToken();


            //       string listab = "Mekteb,*";
            bytestr strbaytitem = new bytestr();
            strbaytitem.name = "yalan"; ;
            strbaytitem.bayt = null;
          
            string sqlConnString = @"Data Source=172.16.0.18;Initial Catalog=" + baza + ";User ID=gisuser;Password=G1s_2014_sqs";

              string tempfolder= Path.GetTempPath();
            string fileName = "no";
            DateTime dd = DateTime.Now;
            // string sqlitePath = Path.GetTempPath() + "DBS" + Path.GetRandomFileName().Split('.')[0];
            string sqlitePath = tempfolder + "DBS" + Path.GetRandomFileName().Split('.')[0];

            sqlitePath += dd.Minute.ToString() + dd.Second.ToString() + ".db";
            fileName = SqlServerToSQLite.ConvertSqlServerToSQLiteDatabase(sqlConnString, sqlitePath, listab);

            GC.Collect();
            string fileNamez = fzip(fileName);
            if (fileNamez == "no") fileNamez = fileName;
            FileStream fs = new FileStream(fileNamez, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            // FileStream fs = new FileStream(fileNamez, FileMode.Open);

            MemoryStream ms = new MemoryStream();
            int buffLength = 1024;
            byte[] buff = new byte[buffLength];





            // Read from the file stream 2kb at a time
            int contentLen = fs.Read(buff, 0, buffLength);

            // Till Stream content ends
            while (contentLen != 0)
            {
                // Write Content from the file stream to the FTP Upload Stream
                ms.Write(buff, 0, contentLen);
                contentLen = fs.Read(buff, 0, buffLength);
            }

            // Close the file stream and the Request Stream

            fs.Close();
            fs.Dispose();
            if (File.Exists(fileName)) File.Delete(fileName);
            if (File.Exists(fileNamez)) File.Delete(fileNamez);
            strbaytitem.name = fileNamez;
            strbaytitem.bayt = ms.ToArray();
            ms.Close();
            ms.Dispose();


            return strbaytitem;
        }

         [WebMethod]
        public bytestr spdown( string baza, string spad)
        {

             CheckToken();

            //       string listab = "Mekteb,*";
            bytestr strbaytitem = new bytestr();
            strbaytitem.name = "yalan"; ;
            strbaytitem.bayt = null;
            



            string sqlConnString = @"Data Source=172.16.0.18;Initial Catalog=" + baza + ";User ID=gisuser;Password=G1s_2014_sqs";
 DateTime dd = DateTime.Now;
 string tname = "sp" +Path.GetRandomFileName().Split('.')[0]+ dd.Minute.ToString() + dd.Second.ToString();
  //  tname = Path.GetRandomFileName().Split('.')[0];
 
             
             // Connect to the SQL Server database
 using (SqlConnection ssconn = new SqlConnection(sqlConnString))
            {
                ssconn.Open();
//[Kadrlar].[dbo].[MobIdare]')"

                SqlCommand cmd = new SqlCommand("SELECT * INTO " + tname + " FROM OpenRowset ( 'SQLOLEDB','Server=(Local);TRUSTED_CONNECTION=YES;', 'EXEC  " +spad+"')" , ssconn);

//"SELECT * INTO 21ezqx11 FROM OpenRowset ( 'SQLOLEDB','Server=(Local);TRUSTED_CONNECTION=YES;', 'EXEC  [Kadrlar].[dbo].[MobIdare]  '"
                int ID = cmd.ExecuteNonQuery();

                ssconn.Close();
            } // using




            string fileName = "no";
             string tempfolder= Path.GetTempPath();
            // string sqlitePath = Path.GetTempPath() + "DBS" + Path.GetRandomFileName().Split('.')[0];
            string sqlitePath = tempfolder + "DBSp" + Path.GetRandomFileName().Split('.')[0];

            sqlitePath += dd.Minute.ToString() + dd.Second.ToString() + ".db";
            fileName = SqlServerToSQLite.ConvertSqlServerToSQLiteDatabase(sqlConnString, sqlitePath, tname+",*");

            GC.Collect();
            FileStream fs = new FileStream(fileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
            // FileStream fs = new FileStream(fileName, FileMode.Open);

            MemoryStream ms = new MemoryStream();
            int buffLength = 1024;
            byte[] buff = new byte[buffLength];





            // Read from the file stream 2kb at a time
            int contentLen = fs.Read(buff, 0, buffLength);

            // Till Stream content ends
            while (contentLen != 0)
            {
                // Write Content from the file stream to the FTP Upload Stream
                ms.Write(buff, 0, contentLen);
                contentLen = fs.Read(buff, 0, buffLength);
            }

            // Close the file stream and the Request Stream

            fs.Close();
            fs.Dispose();
            File.Delete(fileName);

            strbaytitem.name = tname;
            strbaytitem.bayt = ms.ToArray();
            ms.Close();
            ms.Dispose();
            using (SqlConnection ssconn = new SqlConnection(sqlConnString))
            {
                ssconn.Open();
                SqlCommand cmd = new SqlCommand("DROP TABLE " +baza+".dbo."+ tname, ssconn);
       int ID = cmd.ExecuteNonQuery();

                ssconn.Close();
            } // using

            return strbaytitem;
        }
          [WebMethod]
         public bytestr zspdown(  string baza, string spad)
         {

             CheckToken();

             //       string listab = "Mekteb,*";
             bytestr strbaytitem = new bytestr();
             strbaytitem.name = "yalan"; ;
             strbaytitem.bayt = null;
           



             string sqlConnString = @"Data Source=172.16.0.18;Initial Catalog=" + baza + ";User ID=gisuser;Password=G1s_2014_sqs";
             DateTime dd = DateTime.Now;
             string tname = "sp" + Path.GetRandomFileName().Split('.')[0] + dd.Minute.ToString() + dd.Second.ToString();
             //  tname = Path.GetRandomFileName().Split('.')[0];


             // Connect to the SQL Server database
             using (SqlConnection ssconn = new SqlConnection(sqlConnString))
             {
                 ssconn.Open();
                 //[Kadrlar].[dbo].[MobIdare]')"

                 SqlCommand cmd = new SqlCommand("SELECT * INTO " + tname + " FROM OpenRowset ( 'SQLOLEDB','Server=(Local);TRUSTED_CONNECTION=YES;', 'EXEC  " + spad + "')", ssconn);

                 //"SELECT * INTO 21ezqx11 FROM OpenRowset ( 'SQLOLEDB','Server=(Local);TRUSTED_CONNECTION=YES;', 'EXEC  [Kadrlar].[dbo].[MobIdare]  '"
                 int ID = cmd.ExecuteNonQuery();

                 ssconn.Close();
             } // using


               string tempfolder= Path.GetTempPath();

             string fileName = "no";

             // string sqlitePath = Path.GetTempPath() + "DBS" + Path.GetRandomFileName().Split('.')[0];
             string sqlitePath = tempfolder + "DBSp" + Path.GetRandomFileName().Split('.')[0];

             sqlitePath += dd.Minute.ToString() + dd.Second.ToString() + ".db";
             fileName = SqlServerToSQLite.ConvertSqlServerToSQLiteDatabase(sqlConnString, sqlitePath, tname + ",*");

             GC.Collect();
        string   fileNamez=fzip(fileName);
        if (fileNamez == "no") fileNamez = fileName;
             FileStream fs = new FileStream(fileNamez, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
             // FileStream fs = new FileStream(fileNamez, FileMode.Open);

             MemoryStream ms = new MemoryStream();
             int buffLength = 1024;
             byte[] buff = new byte[buffLength];





             // Read from the file stream 2kb at a time
             int contentLen = fs.Read(buff, 0, buffLength);

             // Till Stream content ends
             while (contentLen != 0)
             {
                 // Write Content from the file stream to the FTP Upload Stream
                 ms.Write(buff, 0, contentLen);
                 contentLen = fs.Read(buff, 0, buffLength);
             }

             // Close the file stream and the Request Stream

             fs.Close();
             fs.Dispose();
             if (File.Exists(fileName)) File.Delete(fileName);
if (File.Exists(fileNamez)) File.Delete(fileNamez);
strbaytitem.name = tname +"."+ fileNamez.Split('.')[1];
             strbaytitem.bayt = ms.ToArray();
             ms.Close();
             ms.Dispose();
             using (SqlConnection ssconn = new SqlConnection(sqlConnString))
             {
                 ssconn.Open();
                 SqlCommand cmd = new SqlCommand("DROP TABLE " + baza + ".dbo." + tname, ssconn);
                 int ID = cmd.ExecuteNonQuery();

                 ssconn.Close();
             } // using

             return strbaytitem;
         }
    //    [WebMethod]
        public string Salam()
        {
              CheckToken();

            string sqlConnString;
            string listab = "emeltip,*";
            string res = @"Data Source=172.16.0.18;Initial Catalog=Kadrlar;User ID=gisuser;Password=G1s_2014_sqs";

            sqlConnString = res;
            //      ("ttnda.az,27009", "Avto", "gisuser", "G1s_2014_sqs");

          //  string sqlitePath = @"c:\WS\DBlite\salam";
          
        //       + ".db"; 
            //   string sqlitePath = Path.GetRandomFileName();  
             //   Path.GetTempFileName;
        DateTime dd =     DateTime.Now;

        string sqlitePath =Path.GetTempPath()+"DBS"+ Path.GetRandomFileName().Split('.')[0];
        sqlitePath += dd.Minute.ToString() + dd.Second.ToString() + ".db";
          res = SqlServerToSQLite.ConvertSqlServerToSQLiteDatabase(sqlConnString, sqlitePath, listab);


            return res;
        }


        private  string fzip(string file )//, bool deleteZipOnCompletion)
        {
            string nos = "no";
            try
            {

                // Specifying Console.Out here causes diagnostic msgs to be sent to the Console
                // In a WinForms or WPF or Web app, you could specify nothing, or an alternate
                // TextWriter to capture diagnostic messages. 
                using (ZipFile zip = new ZipFile())
                {


                    ZipEntry e = zip.AddFile(file);
                    

                    zip.Save(file.Split('.')[0]+".zip");
                    //       zip.Save();
                        nos = file.Split('.')[0]+".zip";
                }
            }
            catch (System.Exception)
            {
                return nos;
            }

            return nos;

        }








//public class CustomerList : WebService { 
    [WebMethod] 
    public DataTable Cedvel(string query) {


         
           CheckToken();


        string cnStr = "Data Source=172.16.0.18; Initial Catalog=mufettis; User ID=gisuser; Password=G1s_2014_sqs"; 
      //   = "SELECT TOP 10 * FROM Customers"; 
        SqlConnection cn = new SqlConnection(cnStr); 
        cn.Open();
            if (query.IndexOf("obyektview") >= 0) query = query.Replace("(P.E=", "(P.E<>");
            SqlDataAdapter adpt = new SqlDataAdapter(new SqlCommand(query, cn)); 
      DataTable dt = new DataTable("Cedvel"); 
 
        adpt.Fill(dt);
        cn.Close();
        return dt; 
    }
      [WebMethod] 
        public byte[]   Cedvell(string query)
    {
             CheckToken();
        string cnStr = "Data Source=172.16.0.18; Initial Catalog=mufettis; User ID=gisuser; Password=G1s_2014_sqs";
        //   = "SELECT TOP 10 * FROM Customers"; 
        SqlConnection cn = new SqlConnection(cnStr);
            if (query.IndexOf("obyektview") >= 0) query = query.Replace("(P.E=", "(P.E<>");
            cn.Open();
        SqlDataAdapter adpt = new SqlDataAdapter(new SqlCommand(query, cn));
        DataTable dt = new DataTable("Cedvel");

        adpt.Fill(dt);
byte[]  bbb=Compress(ConvertDataTableToByteArray(dt));
cn.Close();
        return bbb ;
    }  

 [WebMethod]
      public byte[] Cedvells(string query)
    {
       CheckToken();
              
        //   = "SELECT TOP 10 * FROM Customers"; 
        SqlConnection cn = new SqlConnection(cnStr);
        cn.Open();
           if (query.IndexOf("obyektview") >= 0)  query=query.Replace("(P.E=", "(P.E<>");
            SqlDataAdapter adpt = new SqlDataAdapter(new SqlCommand(query, cn));
        DataTable dt = new DataTable("Cedvel");

        adpt.Fill(dt);
     System.IO.StringWriter writer = new System.IO.StringWriter();
  dt.WriteXml(writer,true);


string value= writer.ToString();
  value=  value.Replace(@"xml:space=""preserve""","");
 
 
byte [] bbb= Zipb(value);
cn.Close();
return bbb;

     //   return TableToStr(dt);
    } 



    [WebMethod] 
    public DataSet Cedveliki(string query1,string query2) {

             CheckToken();
        string cnStr = "Data Source=172.16.0.18; Initial Catalog=mufettis; User ID=gisuser; Password=G1s_2014_sqs"; 
      //   = "SELECT TOP 10 CustomerID, CompanyName FROM Customers"; 
   //      = "SELECT TOP 10 OrderID, CustomerID, ShipCity, ShipCountry FROM Orders"; 
        SqlConnection cn = new SqlConnection(cnStr); 
        cn.Open(); 
 
        SqlDataAdapter adpt = new SqlDataAdapter(new SqlCommand(query1, cn)); 
        DataSet ds = new DataSet("DataBaza"); 
        adpt.Fill(ds, "Cedvel1"); 
 
        adpt.SelectCommand = new SqlCommand(query2, cn); 
        adpt.Fill(ds,"Cedvel2");
        cn.Close();
        return ds; 
    } 
//}
    

         
        private static int BUFFER_SIZE = 64*1024; //64kB

        public static byte[] Compressee(byte[] inputData)
        {
            if (inputData == null)
                throw new ArgumentNullException("inputData must be non-null");

            using (var compressIntoMs = new MemoryStream())
            {
                using (var gzs = new BufferedStream(new GZipStream(compressIntoMs, 
                 CompressionMode.Compress), BUFFER_SIZE))
                {
                    gzs.Write(inputData, 0, inputData.Length);
                }
                return compressIntoMs.ToArray(); 
            }
        }

        public static byte[] Decompressee(byte[] inputData)
        {
            if (inputData == null)
                throw new ArgumentNullException("inputData must be non-null");

            using (var compressedMs = new MemoryStream(inputData))
            {
                using (var decompressedMs = new MemoryStream())
                {
                    using (var gzs = new BufferedStream(new GZipStream(compressedMs, 
                     CompressionMode.Decompress), BUFFER_SIZE))
                    {
                      //  gzs.CopyTo(decompressedMs);
 

                    }
                    return decompressedMs.ToArray(); 
                }
            }
        }

  
               //private static void Pump(Stream input, Stream output)
        //{
        //    byte[] bytes = new byte[4096];
        //    int n;
        //    while ((n = input.Read(bytes, 0, bytes.Length)) != 0)
        //    {
        //        output.Write(bytes, 0, n); 
        //    }
        //}

    //    byte[] inputData = File.ReadAllBytes("Lorem1.txt");
    //    byte[] compressedData = ByteArrayCompressionUtility.Compress(inputData);
    //    byte[] decompressedData = ByteArrayCompressionUtility.Decompress(compressedData);

 
 private static byte[] Compress(byte[] buffer)
 {
       MemoryStream ms = new MemoryStream();
       GZipStream gz = new GZipStream(ms, CompressionMode.Compress);

      byte[] binaryDataResult = null;
  
       gz.Write(buffer, 0, buffer.Length);
       gz.Close();
 binaryDataResult =  ms.ToArray();

 return binaryDataResult;
 }

 private static byte[] Decompress(byte[] buffer)
 {
       MemoryStream ms = new MemoryStream();
       ms.Write(buffer, 0, buffer.Length);
       ms.Seek(0, SeekOrigin.Begin);

       GZipStream gz = new GZipStream(ms, CompressionMode.Decompress);
 
       List<byte> bytes = new List<byte>();
       while (true)
       {
             int b = gz.ReadByte();
             if (b == -1)
                   break;

             bytes.Add((byte)b);
       }
       return bytes.ToArray();
 }


 // Convert an object to a byte array
 private byte[] ObjectToByteArray(Object obj)
 {
     if (obj == null)
         return null;
     BinaryFormatter bf = new BinaryFormatter();
     MemoryStream ms = new MemoryStream();
     bf.Serialize(ms, obj);
     return ms.ToArray();
 }
 // Convert a byte array to an Object
 private Object ByteArrayToObject(byte[] arrBytes)
 {
     MemoryStream memStream = new MemoryStream();
     BinaryFormatter binForm = new BinaryFormatter();
     memStream.Write(arrBytes, 0, arrBytes.Length);
     memStream.Seek(0, SeekOrigin.Begin);
     Object obj = (Object)binForm.Deserialize(memStream);
     return obj;
 }

 private byte[] ConvertDataTableToByteArray(DataTable dataTable)
 {
     byte[] binaryDataResult = null;
     using (MemoryStream memStream = new MemoryStream())
     {
         BinaryFormatter brFormatter = new BinaryFormatter();
     dataTable.RemotingFormat = SerializationFormat.Binary;
//    dataTable.RemotingFormat = SerializationFormat.Xml;
         brFormatter.Serialize(memStream, dataTable);
         binaryDataResult = memStream.ToArray();

     }
     return binaryDataResult;
 }


 private byte[] ConvertDataSetToByteArray(DataSet dataSet)
 {
     byte[] binaryDataResult = null;
     using (MemoryStream memStream = new MemoryStream())
     {
         BinaryFormatter brFormatter = new BinaryFormatter();
    
         dataSet.RemotingFormat = SerializationFormat.Binary;
         brFormatter.Serialize(memStream, dataSet);
         binaryDataResult = memStream.ToArray();
     }
     return binaryDataResult;
 }

 public static byte[]  CompstB(string text)
 {
     byte[] buffer = Encoding.UTF8.GetBytes(text);
     MemoryStream ms = new MemoryStream();
     using (GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true))
     {
         zip.Write(buffer, 0, buffer.Length);
     }

     ms.Position = 0;
     MemoryStream outStream = new MemoryStream();

     byte[] compressed = new byte[ms.Length];
     ms.Read(compressed, 0, compressed.Length);

     
     return compressed;
 }
        public static string Compst(string text)
{
byte[] buffer = Encoding.UTF8.GetBytes(text);
MemoryStream ms = new MemoryStream();
using (GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true))
{
zip.Write(buffer, 0, buffer.Length);
}

ms.Position = 0;
MemoryStream outStream = new MemoryStream();

byte[] compressed = new byte[ms.Length];
ms.Read(compressed, 0, compressed.Length);

byte[] gzBuffer = new byte[compressed.Length + 4];
System.Buffer.BlockCopy(compressed, 0, gzBuffer, 4, compressed.Length);
System.Buffer.BlockCopy(BitConverter.GetBytes(buffer.Length), 0, gzBuffer, 0, 4);
return Convert.ToBase64String (gzBuffer);
}

        public static string Decompst(string compressedText)
        {
            byte[] gzBuffer = Convert.FromBase64String(compressedText);
            using (MemoryStream ms = new MemoryStream())
            {
                int msgLength = BitConverter.ToInt32(gzBuffer, 0);
                ms.Write(gzBuffer, 4, (gzBuffer.Length - 4));

                byte[] buffer = new byte[msgLength];

                ms.Position = 0;
                using (GZipStream zip = new GZipStream(ms, CompressionMode.Decompress))
                {
                    zip.Read(buffer, 0, buffer.Length);
                }

                return Encoding.UTF8.GetString(buffer);
            }
        }
 public static byte[]   Zipb(string value)
 {

     var utf8 = Encoding.UTF8;
byte[] byteArray = utf8.GetBytes(value);
value = utf8.GetString(byteArray, 0, byteArray.Length);   

     //Transform string into byte[]  
   //  byte[] byteArray = new byte[value.Length];
 //    int indexBA = 0;
    // foreach (char item in value.ToCharArray())
   //  {
   //      byteArray[indexBA++] = (UTF8Encoding (byte)item;
  //   }

     //Prepare for compress
     System.IO.MemoryStream ms = new System.IO.MemoryStream();
     System.IO.Compression.GZipStream sw = new System.IO.Compression.GZipStream(ms, System.IO.Compression.CompressionMode.Compress);

     //Compress
     sw.Write(byteArray, 0, byteArray.Length);
     //Close, DO NOT FLUSH cause bytes will go missing...
     sw.Close();

     //Transform byte[] zip data to string
     byteArray = ms.ToArray();
  
     ms.Close();
     sw.Dispose();
     ms.Dispose();
     return byteArray;
 }
 public static string Zip(string value)
 {
     //Transform string into byte[]  
     byte[] byteArray = new byte[value.Length];
     int indexBA = 0;
     foreach (char item in value.ToCharArray())
     {
         byteArray[indexBA++] = (byte)item;
     }

     //Prepare for compress
     System.IO.MemoryStream ms = new System.IO.MemoryStream();
     System.IO.Compression.GZipStream sw = new System.IO.Compression.GZipStream(ms, System.IO.Compression.CompressionMode.Compress);

     //Compress
     sw.Write(byteArray, 0, byteArray.Length);
     //Close, DO NOT FLUSH cause bytes will go missing...
     sw.Close();

     //Transform byte[] zip data to string
     byteArray = ms.ToArray();
     System.Text.StringBuilder sB = new System.Text.StringBuilder(byteArray.Length);
     foreach (byte item in byteArray)
     {
         sB.Append((char)item);
     }
     ms.Close();
     sw.Dispose();
     ms.Dispose();
     return sB.ToString();
 }
 public static string UnZip(string value)
 {
     //Transform string into byte[]
     byte[] byteArray = new byte[value.Length];
     int indexBA = 0;
     foreach (char item in value.ToCharArray())
     {
         byteArray[indexBA++] = (byte)item;
     }

     //Prepare for decompress
     System.IO.MemoryStream ms = new System.IO.MemoryStream(byteArray);
     System.IO.Compression.GZipStream sr = new System.IO.Compression.GZipStream(ms,
         System.IO.Compression.CompressionMode.Decompress);

     //Reset variable to collect uncompressed result
     byteArray = new byte[byteArray.Length];

     //Decompress
     int rByte = sr.Read(byteArray, 0, byteArray.Length);

     //Transform byte[] unzip data to string
     System.Text.StringBuilder sB = new System.Text.StringBuilder(rByte);
     //Read the number of bytes GZipStream red and do not a for each bytes in
     //resultByteArray;
     for (int i = 0; i < rByte; i++)
     {
         sB.Append((char)byteArray[i]);
     }
     sr.Close();
     ms.Close();
     sr.Dispose();
     ms.Dispose();
     return sB.ToString();
 }





    }
}