﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace SamHaXePanel.Dialogs
{
    public partial class CreateResourcesFile : Form
    {
        public String ResourceFilePath
        {
            get { return this.locationTXT.Text; }
        }

        public String Version
        {
            get { return this.versionDD.Text; }
        }

        public Boolean Compressed
        {
            get { return this.compressedCB.Checked; }
        }

        public String Package
        {
            get { return this.packageTXT.Text; }
        }

        public CreateResourcesFile()
        {
            InitializeComponent();
            this.okBTN.DialogResult = DialogResult.OK;
            this.browseBTN.Click += new EventHandler(browseBTN_Click);
            this.FormClosing += new FormClosingEventHandler(CreateResourcesFile_FormClosing);
            this.versionDD.Text = "10";
        }

        private void CreateResourcesFile_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (String.IsNullOrEmpty(this.locationTXT.Text) ||
                !Directory.Exists(Path.GetDirectoryName(this.locationTXT.Text)))
            {
                e.Cancel = true;
                // TODO: Put this into resources
                MessageBox.Show("You must enter valid path.");
            }
        }

        private void browseBTN_Click(object sender, EventArgs e)
        {
            SaveFileDialog dialog = new SaveFileDialog();
            dialog.Filter = "";
            // TODO: Put this into resources
            dialog.Title = "Create New Resources File";
            dialog.CheckPathExists = true;
            dialog.DefaultExt = ".xml";
            DialogResult res = dialog.ShowDialog();
            if (res == DialogResult.OK)
            {
                this.locationTXT.Text = dialog.FileName;
            }
        }
    }
}
