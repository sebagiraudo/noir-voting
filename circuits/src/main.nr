use dep::std;

fn main(root: pub Field, hash_paths: [Field; 2], index: Field, secret: Field) {
    let commitment = std::hash::pedersen_hash([secret]);
    let check_root = std::merkle::compute_merkle_root(commitment, index, hash_paths);   
    assert (check_root == root);
}

#[test]
fn main_test() {
    let comm_1 = std::hash::pedersen_hash([1]);
    let comm_2 = std::hash::pedersen_hash([2]);
    let comm_3 = std::hash::pedersen_hash([3]);
    let comm_4 = std::hash::pedersen_hash([4]);

    //           root
    //        /        \
    //       /          \
    // left_branch    right_branch
    //     /  \           /  \
    // comm_1 comm_2  comm_3 comm_4

    let left_branch = std::hash::pedersen_hash([comm_1, comm_2]);
    let right_branch = std::hash::pedersen_hash([comm_3, comm_4]);
    
    let root = std::hash::pedersen_hash([left_branch,  right_branch]);

    // For User 1:
    //           root
    //        /        \
    //       /          \
    // left_branch   [right_branch]
    //     /  \           /  \
    // comm_1[comm_2] comm_3 comm_4

    let hash_paths = [comm_2, right_branch];

    main(root, hash_paths, 0, 1);


    // For User 3:
    //           root
    //        /        \
    //       /          \
    //[left_branch]   right_branch
    //     /  \           /  \
    // comm_1 comm_2  comm_3[comm_4]
    let hash_paths3 = [comm_4, left_branch];

    main(root, hash_paths3, 2, 3);
}

// comm1        0x03542cb720369f19a74fd05b4edfbedb27a78514ad3283f1b3270a1656cced8e
// comm2        0x1efa9d6bb4dfdf86063cc77efdec90eb9262079230f1898049efad264835b6c8
// comm3        0x24013340c052ebf847e0d7081f84e6a8e92f54e2e1726a1e559ac46a8f242007
// comm4        0x04fd3da9756f25c72ca8990437b7f7b58e7ca48bfc21e65e7978320db8b1e5c5
// left_branch  0x046394ae1ebbf494f2cd2c2d37171099510d099489c9accef59f90512d5f0477
// right_branch 0x2a653551d87767c545a2a11b29f0581a392b4e177a87c8e3eb425c51a26a8c77
// root         0x215597bacd9c7e977dfc170f320074155de974be494579d2586e5b268fa3b629