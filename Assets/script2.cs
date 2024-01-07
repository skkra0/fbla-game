using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class script2 : MonoBehaviour
{
    public float moveSpeed = 5f;
    public Rigidbody2D rb;

    Vector2 moveDirection;

    // Update is called once per frame
    void Update()
    {
        float moveX = Input.GetAxisRaw("Horizontal2");
        float moveY = Input.GetAxisRaw("Vertical2");


        moveDirection = new Vector2(moveX, moveY).normalized;
    }

    private void FixedUpdate()
    {
        rb.velocity = new Vector2(moveDirection.x * moveSpeed, moveDirection.y * moveSpeed);
    }
}
