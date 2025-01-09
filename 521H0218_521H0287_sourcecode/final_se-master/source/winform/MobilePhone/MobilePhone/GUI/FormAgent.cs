using BLL;
using DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MobilePhone.GUI
{
    public partial class FormAgent : Form
    {
        private AgentService agent = new AgentService();

        public FormAgent()
        {
            InitializeComponent();
        }

        public void showGRD()
        {
            tableAgent.DataSource = agent.getAll();
        }

        public void clearText()
        {
            txtID.Text = "";
            txtName.Text = "";
            txtAdd.Text = "";
            txtContact.Text = "";
            txtPass.Text = "";
        }

        private void btnAll_Click(object sender, EventArgs e)
        {
            showGRD();
        }

        private void FormAgent_Load(object sender, EventArgs e)
        {
            showGRD();
            inforGroup.Enabled = false;
            btnDelete.Enabled = false; 
            btnSave.Enabled = false;
            btnUpdate.Enabled = false;
        }

        private void tableAgent_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txtID.Text = tableAgent.CurrentRow.Cells[0].Value.ToString();
            txtName.Text = tableAgent.CurrentRow.Cells[1].Value.ToString();
            txtAdd.Text = tableAgent.CurrentRow.Cells[2].Value.ToString();
            txtContact.Text = tableAgent.CurrentRow.Cells[3].Value.ToString();
            txtPass.Text = tableAgent.CurrentRow.Cells[4].Value.ToString();

            inforGroup.Enabled = true;
            btnDelete.Enabled = true;
            btnSave.Enabled = true;
            btnUpdate.Enabled = true;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            tableAgent.DataSource = agent.find(txtSearch.Text);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            btnDelete.Enabled = true;
            btnSave.Enabled = true;
            btnUpdate.Enabled = true;
            inforGroup.Enabled = true;

            clearText();
            txtID.Focus();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Agent a = new Agent(txtID.Text, txtName.Text, txtAdd.Text, txtContact.Text,txtPass.Text);
            try
            {
                agent.save(a);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), "Error!",MessageBoxButtons.OK);
            }
            clearText();
            showGRD();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            agent.delete(txtID.Text);
            clearText();
            showGRD();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            Agent a = new Agent(txtID.Text, txtName.Text, txtAdd.Text, txtContact.Text, txtPass.Text);
            agent.saveChange(a);
            clearText();
            showGRD();
        }

    }
}
