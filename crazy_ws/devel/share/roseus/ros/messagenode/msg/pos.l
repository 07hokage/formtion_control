;; Auto-generated. Do not edit!


(when (boundp 'messagenode::pos)
  (if (not (find-package "MESSAGENODE"))
    (make-package "MESSAGENODE"))
  (shadow 'pos (find-package "MESSAGENODE")))
(unless (find-package "MESSAGENODE::POS")
  (make-package "MESSAGENODE::POS"))

(in-package "ROS")
;;//! \htmlinclude pos.msg.html


(defclass messagenode::pos
  :super ros::object
  :slots (_custom_msg ))

(defmethod messagenode::pos
  (:init
   (&key
    ((:custom_msg __custom_msg) "")
    )
   (send-super :init)
   (setq _custom_msg (string __custom_msg))
   self)
  (:custom_msg
   (&optional __custom_msg)
   (if __custom_msg (setq _custom_msg __custom_msg)) _custom_msg)
  (:serialization-length
   ()
   (+
    ;; string _custom_msg
    4 (length _custom_msg)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _custom_msg
       (write-long (length _custom_msg) s) (princ _custom_msg s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _custom_msg
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _custom_msg (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get messagenode::pos :md5sum-) "34bc0b7b6938cfa2480828862cdaf1a1")
(setf (get messagenode::pos :datatype-) "messagenode/pos")
(setf (get messagenode::pos :definition-)
      "string custom_msg

")



(provide :messagenode/pos "34bc0b7b6938cfa2480828862cdaf1a1")


