using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using IMDB.Models;

namespace IMDB.BLL
{
    public class CommonClass
    {

        // sql connection
        SqlCommand cmd = null;
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        // save movies, actors, producers
        public string saveActorDetails(ModelActor _model)
        {
            string result = string.Empty;
            try
            {
                conn = ConntectionOpen();
                SqlCommand cmd = new SqlCommand("Usp_Actors_AddEdit", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@pUID", _model.UID);
                cmd.Parameters.AddWithValue("@pName", _model.Name);
                cmd.Parameters.AddWithValue("@pSex", _model.Sex);
                cmd.Parameters.AddWithValue("@pDOB", _model.DOB);
                cmd.Parameters.AddWithValue("@pBio", _model.Bio);
                cmd.Parameters.AddWithValue("@pInsertedBy", "Admin");
                cmd.Parameters.AddWithValue("@pMode", _model.Mode);
                cmd.Parameters.Add("@pMsg", SqlDbType.NChar, 200);
                cmd.Parameters["@pMsg"].Direction = ParameterDirection.Output;
                result = cmd.ExecuteNonQuery().ToString();
                string returnedfromDB = cmd.Parameters["@pMsg"].Value.ToString();
                if (returnedfromDB != "")
                {
                    result = returnedfromDB;
                }
            }
            catch (Exception ex)
            {
                result = ex.Message.ToString();
            }
            finally
            {
                conn.Close();
            }
            return result;
        }

        public string saveProducerDetails(ModelProducer _model)
        {
            string result = string.Empty;
            try
            {
                conn = ConntectionOpen();
                SqlCommand cmd = new SqlCommand("Usp_Producers_AddEdit", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@pUID", _model.UID);
                cmd.Parameters.AddWithValue("@pName", _model.Name);
                cmd.Parameters.AddWithValue("@pSex", _model.Sex);
                cmd.Parameters.AddWithValue("@pDOB", _model.DOB);
                cmd.Parameters.AddWithValue("@pBio", _model.Bio);
                cmd.Parameters.AddWithValue("@pInsertedBy", "Admin");
                cmd.Parameters.AddWithValue("@pMode", _model.Mode);
                cmd.Parameters.Add("@pMsg", SqlDbType.NChar, 200);
                cmd.Parameters["@pMsg"].Direction = ParameterDirection.Output;
                result = cmd.ExecuteNonQuery().ToString();
                string returnedfromDB = cmd.Parameters["@pMsg"].Value.ToString();
                if (returnedfromDB != "")
                {
                    result = returnedfromDB;
                }
            }
            catch (Exception ex)
            {
                result = ex.Message.ToString();
            }
            finally
            {
                conn.Close();
            }
            return result;
        }

        public string saveMovieDetails(ModelMovie _model, string uniqueFilePath)
        {
            string result = string.Empty;

            try
            {
                conn = ConntectionOpen();
                SqlCommand cmd = new SqlCommand("Usp_Movies_AddEdit", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@pUID", _model.UID);
                cmd.Parameters.AddWithValue("@pName", _model.Name);
                cmd.Parameters.AddWithValue("@pYearOfRelease", _model.YearOfRelease);
                cmd.Parameters.AddWithValue("@pProduderId", _model.Producer);
                cmd.Parameters.AddWithValue("@pActorsId", _model.Actors);
                cmd.Parameters.AddWithValue("@pPlot", _model.Plot);
                cmd.Parameters.AddWithValue("@pPosterPath", uniqueFilePath);
                cmd.Parameters.AddWithValue("@pInsertedBy", "Admin");
                cmd.Parameters.AddWithValue("@pMode", _model.Mode);
                cmd.Parameters.Add("@pMsg", SqlDbType.NChar, 200);
                cmd.Parameters["@pMsg"].Direction = ParameterDirection.Output;
                result = cmd.ExecuteNonQuery().ToString();
                string returnedfromDB = cmd.Parameters["@pMsg"].Value.ToString();
                if (returnedfromDB != "")
                {
                    result = returnedfromDB;
                }
            }
            catch (Exception ex)
            {
                result = ex.Message.ToString();
            }
            finally
            {
                conn.Close();
            }
            return result;
        }

        // search movies, actors, producers
        public List<ModelActor> searchActorDetails(string actorName)
        {
            List<ModelActor> list = new List<ModelActor>();
            try
            {
                using (cmd = new SqlCommand("Usp_Actors_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pName", actorName);
                    cmd.Parameters.AddWithValue("@pMode", "Search");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelActor obj = new ModelActor();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                obj.Sex = dr["Sex"].ToString();
                                obj.DOB = dr["DOB"].ToString();
                                obj.Bio = dr["Bio"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        public List<ModelProducer> searchProducerDetails(string producerName)
        {
            List<ModelProducer> list = new List<ModelProducer>();
            try
            {
                using (cmd = new SqlCommand("Usp_Producers_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pName", producerName);
                    cmd.Parameters.AddWithValue("@pMode", "Search");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelProducer obj = new ModelProducer();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                obj.Sex = dr["Sex"].ToString();
                                obj.DOB = dr["DOB"].ToString();
                                obj.Bio = dr["Bio"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        public List<ModelMovie> searchMovieDetails(string movieName)
        {
            List<ModelMovie> list = new List<ModelMovie>();
            try
            {
                using (cmd = new SqlCommand("Usp_Movies_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pName", movieName);
                    cmd.Parameters.AddWithValue("@pMode", "Search");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelMovie obj = new ModelMovie();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                obj.YearOfRelease = dr["YearOfRelease"].ToString();
                                obj.Producer = dr["ProducerName"].ToString();
                                obj.Actors = dr["ActorName"].ToString();
                                obj.Plot = dr["Plot"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        // Bind DDl's
        public List<ModelActor> BindDdlActors()
        {
            List<ModelActor> list = new List<ModelActor>();
            try
            {
                using (cmd = new SqlCommand("Usp_Actors_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pMode", "Select");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelActor obj = new ModelActor();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        public List<ModelActor> BindDDLProducers()
        {
            List<ModelActor> list = new List<ModelActor>();
            try
            {
                using (cmd = new SqlCommand("Usp_Producers_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pMode", "Select");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelActor obj = new ModelActor();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        public List<ModelMovie> DisplayMoviesPosters()
        {
            List<ModelMovie> list = new List<ModelMovie>();
            try
            {
                using (cmd = new SqlCommand("Usp_Movies_AddEdit", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pMode", "SelectAll");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                DataRow dr = ds.Tables[0].Rows[i];
                                ModelMovie obj = new ModelMovie();
                                obj.UID = Convert.ToInt64(dr["UID"]);
                                obj.Name = dr["Name"].ToString();
                                obj.YearOfRelease = dr["YearOfRelease"].ToString();
                                obj.Producer = dr["ProducerName"].ToString();
                                obj.Actors = dr["ActorName"].ToString();
                                obj.PosterFile = dr["PosterUrl"].ToString();
                                obj.Plot = dr["Plot"].ToString();
                                list.Add(obj);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return list;

        }

        // Sql Connection open/close
        SqlConnection con = null;
        string c = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        public SqlConnection ConntectionOpen()
        {
            try
            {
                con = new SqlConnection(c);
                con.Open();
            }
            catch
            {
                throw;
            }
            return con;
        }
        public void ConnectionClose(SqlConnection con)
        {
            try
            {
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
            catch
            {
                throw;
            }
        }
        // end of .cs
    }
}