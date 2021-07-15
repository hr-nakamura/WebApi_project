using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace Util
{
    class IniFile
    {
        private static Dictionary<string, Dictionary<string, string>> Buff;
        private static Boolean status = false;
        public IniFile(string file)
        {
            status =  File.Exists(file);
            if(status)
            {
                Buff = _ReadIni(file);
            }
        }
        public string[] GetSectionNames()
        {
            return (_GetSectionNames());
        }
        public string[] GetKeyNames(string sectionName)
        {
            return (_GetKeyNames(sectionName));
        }

        public string GetValue(string sectionName, string key, string defaultValue)
        {
            string work = (_ContainsKey(sectionName, key) ? Buff[sectionName][key] : defaultValue);
            return (work);
        }
        public static string[] _GetSectionNames()
        {
            List<string> work = new List<string>();
            if (!status) return (work.ToArray());
            foreach (var section in Buff)
            {
                work.Add(section.Key);

            }
            return (work.ToArray());
        }
        public static string[] _GetKeyNames(string sectionName)
        {
            List<string> work = new List<string>();
            if (!_ContainsSection(sectionName))
            {
                return (work.ToArray());
            }
            foreach (var pair in Buff[sectionName])
            {
                work.Add(pair.Key);

            }
            return (work.ToArray());
        }

        private static bool _ContainsSection(string sectionName)
        {
            return Array.FindIndex<string>(_GetSectionNames(), (string x) => x.ToUpper() == sectionName.ToUpper()) != -1;
        }
        private static bool _ContainsKey(string sectionName, string keyName)
        {
            return Array.FindIndex<string>(_GetKeyNames(sectionName), (string x) => x.ToUpper() == keyName.ToUpper()) != -1;
        }
        private static Dictionary<string, Dictionary<string, string>> _ReadIni(string file)
        {
            Encoding Encode = Encoding.GetEncoding("Shift_JIS");
            using (var reader = new StreamReader(file, Encode))
            {
                var sections = new Dictionary<string, Dictionary<string, string>>(StringComparer.Ordinal);
                var regexSection = new Regex(@"^\s*\[(?<section>[^\]]+)\].*$", RegexOptions.Singleline | RegexOptions.CultureInvariant);
                var regexNameValue = new Regex(@"^\s*(?<name>[^=]+)=(?<value>.*?)(\s?;(?<comment>.*))?$", RegexOptions.Singleline | RegexOptions.CultureInvariant);
                var currentSection = string.Empty;

                // セクション名が明示されていない先頭部分のセクション名を""として扱う
                sections[string.Empty] = new Dictionary<string, string>();

                for (; ; )
                {
                    var line = reader.ReadLine();

                    if (line == null)
                        break;

                    // 空行は読み飛ばす
                    if (line.Length == 0)
                        continue;

                    // コメント行は読み飛ばす
                    if (line.StartsWith(";", StringComparison.Ordinal))
                        continue;
                    else if (line.StartsWith("#", StringComparison.Ordinal))
                        continue;

                    var matchNameValue = regexNameValue.Match(line);

                    if (matchNameValue.Success)
                    {
                        // name=valueの行
                        sections[currentSection][matchNameValue.Groups["name"].Value.Trim()] = matchNameValue.Groups["value"].Value.Trim();
                        continue;
                    }

                    var matchSection = regexSection.Match(line);

                    if (matchSection.Success)
                    {
                        // [section]の行
                        currentSection = matchSection.Groups["section"].Value;

                        if (!sections.ContainsKey(currentSection))
                            sections[currentSection] = new Dictionary<string, string>();

                        continue;
                    }
                }

                return sections;
            }
        }

    }
}