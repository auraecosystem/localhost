/**
 * Modern Vala bindings for util-linux libblkid.
 *
 * Compile with:
 *   --pkg posix
 *
 * Link with:
 *   -lblkid
 *
 * Example:
 *   valac --pkg posix --vapidir=. --pkg blkid example.vala
 */

[CCode (
    cheader_filename = "blkid/blkid.h",
    cprefix = "blkid_"
)]
namespace BlkId {

    /*
     * ------------------------------------------------------------
     * Constants
     * ------------------------------------------------------------
     */

    [CCode (cname = "BLKID_DATE")]
    public const string DATE;

    [CCode (cname = "BLKID_VERSION")]
    public const string VERSION;


    /*
     * ------------------------------------------------------------
     * Filters
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "int",
        cprefix = "BLKID_FLTR_",
        has_type_id = false
    )]
    public enum Filter {
        NOTIN,
        ONLYIN
    }


    /*
     * ------------------------------------------------------------
     * Cache lookup modes
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "int",
        cprefix = "BLKID_DEV_",
        has_type_id = false
    )]
    [Flags]
    public enum Get {
        FIND,
        CREATE,
        VERIFY,
        NORMAL
    }


    /*
     * ------------------------------------------------------------
     * Partition information flags
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "unsigned long long",
        cprefix = "BLKID_PARTS_",
        has_type_id = false
    )]
    [Flags]
    public enum PartInfo {
        FORCE_GPT,
        ENTRY_DETAILS
    }


    /*
     * ------------------------------------------------------------
     * Superblock probing flags
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "int",
        cprefix = "BLKID_SUBLKS_",
        has_type_id = false
    )]
    [Flags]
    public enum SuperBlock {
        LABEL,
        LABELRAW,
        UUID,
        UUIDRAW,
        TYPE,
        SECTYPE,
        USAGE,
        VERSION,
        MAGIC,
        DEFAULT
    }


    /*
     * ------------------------------------------------------------
     * Usage types
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "int",
        cprefix = "BLKID_USAGE_",
        has_type_id = false
    )]
    [Flags]
    public enum Usage {
        FILESYSTEM,
        RAID,
        CRYPTO,
        OTHER
    }


    /*
     * ------------------------------------------------------------
     * High-level cache
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_cache",
        free_function = "blkid_put_cache",
        has_type_id = false
    )]
    [Compact]
    public class Cache {

        [CCode (cname = "blkid_get_cache")]
        public static int open (
            out Cache? cache,
            string? filename = null
        );

        [CCode (cname = "blkid_gc_cache")]
        public void collect_garbage ();

        [CCode (cname = "blkid_find_dev_with_tag")]
        public unowned Device? find_dev_with_tag (
            string type,
            string value
        );

        [CCode (cname = "blkid_get_dev")]
        public unowned Device? get (
            string devname,
            Get flags
        );

        [CCode (cname = "blkid_get_devname")]
        public string? get_name (
            string token,
            string value
        );

        [CCode (cname = "blkid_get_tag_value")]
        public string? get_tag_value (
            string tagname,
            string devname
        );

        [CCode (cname = "blkid_dev_iterate_begin")]
        public DevIterate iterator ();

        [CCode (cname = "blkid_probe_all")]
        public int probe_all ();

        [CCode (cname = "blkid_probe_all_new")]
        public int probe_all_new ();

        [CCode (cname = "blkid_probe_all_removable")]
        public int probe_all_removable ();

        [CCode (cname = "blkid_verify")]
        public Device? verify (
            owned Device dev
        );
    }


    /*
     * ------------------------------------------------------------
     * Device
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_dev",
        has_type_id = false
    )]
    [Compact]
    public class Device {

        [CCode (cname = "blkid_dev_has_tag")]
        public bool has_tag (
            string type,
            string value
        );

        public string? name {
            [CCode (cname = "blkid_dev_devname")]
            get;
        }

        [CCode (cname = "blkid_tag_iterate_begin")]
        public TagIterate iterator ();
    }


    /*
     * ------------------------------------------------------------
     * Device iterator
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_dev_iterate",
        free_function = "blkid_dev_iterate_end",
        has_type_id = false
    )]
    [Compact]
    public class DevIterate {

        [CCode (cname = "blkid_dev_next")]
        public int next (
            out unowned Device? dev
        );

        public unowned Device? next_value () {
            unowned Device? dev;

            if (next (out dev) != 0)
                return null;

            return dev;
        }

        [CCode (cname = "blkid_dev_set_search")]
        public int set_search (
            string search_type,
            string search_value
        );
    }


    /*
     * ------------------------------------------------------------
     * Tag iterator
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_tag_iterate",
        free_function = "blkid_tag_iterate_end",
        has_type_id = false
    )]
    [Compact]
    public class TagIterate {

        [CCode (cname = "blkid_tag_next")]
        public int next_tag (
            out unowned string? type,
            out unowned string? value
        );

        public string[]? next_value () {
            unowned string? type;
            unowned string? value;

            if (next_tag (out type, out value) != 0)
                return null;

            return new string[] {
                type != null ? type : "",
                value != null ? value : ""
            };
        }
    }


    /*
     * ------------------------------------------------------------
     * Partition table
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_parttable",
        has_type_id = false
    )]
    [Compact]
    public class PartTable {

        public int64 offset {
            [CCode (cname = "blkid_parttable_get_offset")]
            get;
        }

        public unowned Partition? parent {
            [CCode (cname = "blkid_parttable_get_parent")]
            get;
        }

        public string? type {
            [CCode (cname = "blkid_parttable_get_type")]
            get;
        }
    }


    /*
     * ------------------------------------------------------------
     * Partition
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_partition",
        has_type_id = false
    )]
    [Compact]
    public class Partition {

        public PartInfo flags {
            [CCode (cname = "blkid_partition_get_flags")]
            get;
        }

        public bool is_extended {
            [CCode (cname = "blkid_partition_is_extended")]
            get;
        }

        public bool is_logical {
            [CCode (cname = "blkid_partition_is_logical")]
            get;
        }

        public bool is_primary {
            [CCode (cname = "blkid_partition_is_primary")]
            get;
        }

        public string? name {
            [CCode (cname = "blkid_partition_get_name")]
            get;
        }

        public int number {
            [CCode (cname = "blkid_partition_get_partno")]
            get;
        }

        public int64 size {
            [CCode (cname = "blkid_partition_get_size")]
            get;
        }

        public int64 start {
            [CCode (cname = "blkid_partition_get_start")]
            get;
        }

        public unowned PartTable table {
            [CCode (cname = "blkid_partition_get_table")]
            get;
        }

        public int type {
            [CCode (cname = "blkid_partition_get_type")]
            get;
        }

        public string? type_name {
            [CCode (cname = "blkid_partition_get_type_string")]
            get;
        }

        public string? uuid {
            [CCode (cname = "blkid_partition_get_uuid")]
            get;
        }
    }


    /*
     * ------------------------------------------------------------
     * Partition list
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_partlist",
        has_type_id = false
    )]
    [Compact]
    public class PartList {

        public unowned PartTable table {
            [CCode (cname = "blkid_partlist_get_table")]
            get;
        }

        public int size {
            [CCode (cname = "blkid_partlist_numof_partitions")]
            get;
        }

        [CCode (cname = "blkid_partlist_get_partition")]
        public unowned Partition? get (
            int index
        );

        [CCode (cname = "blkid_partlist_devno_to_partition")]
        public unowned Partition? get_by_dev_no (
            Posix.dev_t devno
        );
    }


    /*
     * ------------------------------------------------------------
     * Device topology
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_topology",
        has_type_id = false
    )]
    [Compact]
    public class Topology {

        public ulong alignment_offset {
            [CCode (cname = "blkid_topology_get_alignment_offset")]
            get;
        }

        public ulong logical_sector_size {
            [CCode (cname = "blkid_topology_get_logical_sector_size")]
            get;
        }

        public ulong minimum_io_size {
            [CCode (cname = "blkid_topology_get_minimum_io_size")]
            get;
        }

        public ulong optimal_io_size {
            [CCode (cname = "blkid_topology_get_optimal_io_size")]
            get;
        }

        public ulong physical_sector_size {
            [CCode (cname = "blkid_topology_get_physical_sector_size")]
            get;
        }
    }


    /*
     * ------------------------------------------------------------
     * Low-level probe
     *
     * This is the central object.
     *
     * Instead of pretending that PartitionFilter and
     * SuperblockFilter are separate C objects, filtering operations
     * are exposed directly on Prober because libblkid operates on
     * blkid_probe itself.
     * ------------------------------------------------------------
     */

    [CCode (
        cname = "struct blkid_struct_probe",
        free_function = "blkid_free_probe",
        has_type_id = false
    )]
    [Compact]
    public class Prober {

        /*
         * Construction
         */

        [CCode (cname = "blkid_new_probe")]
        public Prober ();

        [CCode (cname = "blkid_new_probe_from_filename")]
        public static Prober? open (
            string filename
        );


        /*
         * Device information
         */

        public Posix.dev_t devno {
            [CCode (cname = "blkid_probe_get_devno")]
            get;
        }

        public int fd {
            [CCode (cname = "blkid_probe_get_fd")]
            get;
        }

        public int64 offset {
            [CCode (cname = "blkid_probe_get_offset")]
            get;
        }

        public int64 size {
            [CCode (cname = "blkid_probe_get_size")]
            get;
        }

        public int64 sectors {
            [CCode (cname = "blkid_probe_get_sectors")]
            get;
        }

        public uint sector_size {
            [CCode (cname = "blkid_probe_get_sectorsize")]
            get;
        }

        public bool is_whole_disk {
            [CCode (cname = "blkid_probe_is_wholedisk")]
            get;
        }

        public Posix.dev_t whole_disk_devno {
            [CCode (cname = "blkid_probe_get_wholedisk_devno")]
            get;
        }


        /*
         * Topology
         */

        public bool enable_topology {
            [CCode (cname = "blkid_probe_enable_topology")]
            set;
        }

        public unowned Topology? topology {
            [CCode (cname = "blkid_probe_get_topology")]
            get;
        }


        /*
         * Partition probing
         */

        public unowned PartList? partitions {
            [CCode (cname = "blkid_probe_get_partitions")]
            get;
        }

        [CCode (cname = "blkid_probe_enable_partitions")]
        public int enable_partitions (
            bool enabled
        );

        [CCode (cname = "blkid_probe_set_partitions_flags")]
        public int set_partition_flags (
            PartInfo flags
        );

        [CCode (cname = "blkid_probe_invert_partitions_filter")]
        public int invert_partition_filter ();

        [CCode (cname = "blkid_probe_reset_partitions_filter")]
        public int reset_partition_filter ();

        [CCode (cname = "blkid_probe_filter_partitions_type")]
        public int filter_partition_type (
            Filter flag,
            [CCode (array_null_terminated = true)]
            string[] names
        );


        /*
         * Superblock probing
         */

        [CCode (cname = "blkid_probe_enable_superblocks")]
        public int enable_superblocks (
            bool enabled
        );

        [CCode (cname = "blkid_probe_set_superblocks_flags")]
        public int set_superblock_flags (
            SuperBlock flags
        );

        [CCode (cname = "blkid_probe_invert_superblocks_filter")]
        public int invert_superblock_filter ();

        [CCode (cname = "blkid_probe_reset_superblocks_filter")]
        public int reset_superblock_filter ();

        [CCode (cname = "blkid_probe_filter_superblocks_type")]
        public int filter_superblock_type (
            Filter flag,
            [CCode (array_null_terminated = true)]
            string[] names
        );

        [CCode (cname = "blkid_probe_filter_superblocks_usage")]
        public int filter_superblock_usage (
            Filter flag,
            Usage usage
        );


        /*
         * Probe execution
         */

        [CCode (cname = "blkid_probe_set_device")]
        public int set_device (
            int fd,
            int64 offset,
            int64 size
        );

        [CCode (cname = "blkid_do_probe")]
        public int do_probe ();

        [CCode (cname = "blkid_do_fullprobe")]
        public int do_full_probe ();

        [CCode (cname = "blkid_do_safeprobe")]
        public int do_safe_probe ();

        [CCode (cname = "blkid_reset_probe")]
        public void reset ();


        /*
         * Probe values
         */

        public int value_count {
            [CCode (cname = "blkid_probe_numof_values")]
            get;
        }

        [CCode (cname = "blkid_probe_has_value")]
        public bool contains (
            string name
        );

        [CCode (cname = "blkid_probe_get_value")]
        public int get_value (
            int index,
            out unowned string name,
            [CCode (array_length_type = "size_t")]
            out unowned uint8[]? data
        );

        [CCode (cname = "blkid_probe_lookup_value")]
        public int lookup_value (
            string name,
            [CCode (array_length_type = "size_t")]
            out unowned uint8[]? data
        );
    }


    /*
     * ------------------------------------------------------------
     * Utility functions
     * ------------------------------------------------------------
     */

    [CCode (cname = "blkid_devno_to_devname")]
    public string? devno_to_name (
        Posix.dev_t devno
    );

    [CCode (cname = "blkid_devno_to_wholedisk")]
    public int devno_to_wholedisk (
        Posix.dev_t dev,
        [CCode (array_length_type = "size_t")]
        uint8[]? buffer,
        out Posix.dev_t diskdevno
    );

    [CCode (cname = "blkid_encode_string")]
    public int encode_string (
        string str,
        [CCode (array_length_type = "size_t")]
        uint8[] buffer
    );

    [CCode (cname = "blkid_evaluate_spec")]
    public string? evaluate_spec (
        string token,
        Cache? cache = null
    );

    [CCode (cname = "blkid_evaluate_tag")]
    public string? evaluate_tag (
        string token,
        string value,
        Cache? cache = null
    );

    [CCode (cname = "blkid_get_dev_size")]
    public int64 get_dev_size (
        int fd
    );

    [CCode (cname = "blkid_superblocks_get_name")]
    public int get_superblock_name (
        size_t index,
        out unowned string? name,
        out Usage usage
    );

    [CCode (cname = "blkid_get_library_version")]
    public int get_version (
        out unowned string version,
        out unowned string date
    );

    [CCode (cname = "blkid_known_fstype")]
    public bool is_known_fs_type (
        string fstype
    );

    [CCode (cname = "blkid_known_pttype")]
    public bool is_known_part_type (
        string pttype
    );

    [CCode (cname = "blkid_parse_tag_string")]
    public int parse_tag_string (
        string token,
        out string? type,
        out string? value
    );

    [CCode (cname = "blkid_parse_version_string")]
    public int parse_version (
        string version
    );

    [CCode (cname = "blkid_safe_string")]
    public int safe_string (
        [CCode (array_length_type = "size_t")]
        uint8[] buffer
    );

    [CCode (cname = "blkid_send_uevent")]
    public int send_uevent (
        string devname,
        string action
    );
}
